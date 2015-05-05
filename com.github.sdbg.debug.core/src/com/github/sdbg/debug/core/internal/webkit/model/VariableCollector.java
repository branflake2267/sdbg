/*
 * Copyright (c) 2012, the Dart project authors.
 * 
 * Licensed under the Eclipse Public License v1.0 (the "License"); you may not use this file except
 * in compliance with the License. You may obtain a copy of the License at
 * 
 * http://www.eclipse.org/legal/epl-v10.html
 * 
 * Unless required by applicable law or agreed to in writing, software distributed under the License
 * is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
 * or implied. See the License for the specific language governing permissions and limitations under
 * the License.
 */

package com.github.sdbg.debug.core.internal.webkit.model;

import com.github.sdbg.debug.core.SDBGDebugCorePlugin;
import com.github.sdbg.debug.core.internal.webkit.protocol.WebkitCallback;
import com.github.sdbg.debug.core.internal.webkit.protocol.WebkitPropertyDescriptor;
import com.github.sdbg.debug.core.internal.webkit.protocol.WebkitRemoteObject;
import com.github.sdbg.debug.core.internal.webkit.protocol.WebkitResult;
import com.github.sdbg.debug.core.internal.webkit.protocol.WebkitScope;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.CountDownLatch;

import org.eclipse.debug.core.model.IVariable;

/**
 * A helper class to asynchronously collect variable values for the WebkitDebugStackFrame class.
 */
class VariableCollector {

  private WebkitDebugTarget target;

  private WebkitDebugVariable parentVariable;

  private CountDownLatch latch;

  private List<IVariable> variables = new ArrayList<IVariable>();

  private List<WebkitPropertyDescriptor> webkitProperties = new ArrayList<WebkitPropertyDescriptor>();

  public static VariableCollector createCollector(WebkitDebugTarget target,
      final WebkitDebugVariable variable, List<WebkitRemoteObject> remoteObjects) {
    final VariableCollector collector = new VariableCollector(
        target,
        remoteObjects.size(),
        variable);

    for (final WebkitRemoteObject obj : remoteObjects) {
      try {
        target.getConnection().getRuntime().getProperties(
            obj,
            true,
            false,
            new WebkitCallback<WebkitPropertyDescriptor[]>() {
              @Override
              public void handleResult(WebkitResult<WebkitPropertyDescriptor[]> result) {
                try {
                  collector.collectFields(
                      result,
                      !obj.isList(),
                      variable != null && variable.isScope() && "global".equals(variable.getName()),
                      variable != null && variable.isScope() && "local".equals(variable.getName()));
                } catch (Throwable t) {
                  SDBGDebugCorePlugin.logError(t);
                  collector.worked();
                }
              }
            });
      } catch (Throwable e) {
        SDBGDebugCorePlugin.logError(e);

        collector.worked();
      }
    }

    return collector;
  }

  public static VariableCollector createCollector(WebkitDebugTarget target,
      WebkitRemoteObject thisObject, WebkitRemoteObject exception, boolean flattenLocalScope,
      WebkitScope... scopes) {
    final VariableCollector collector = new VariableCollector(target, flattenLocalScope ? 1 : 0);

    if (thisObject != null) {
      collector.createThisVariable(thisObject);
    }

    if (exception != null) {
      collector.createExceptionVariable(exception);
    }

    if (flattenLocalScope) {
      for (WebkitScope scope : scopes) {
        if (scope.isLocal()) {
          try {
            target.getConnection().getRuntime().getProperties(
                scope.getObject(),
                true,
                false,
                new WebkitCallback<WebkitPropertyDescriptor[]>() {
                  @Override
                  public void handleResult(WebkitResult<WebkitPropertyDescriptor[]> result) {
                    try {
                      collector.collectFields(result, true, false, true);
                    } catch (Throwable t) {
                      SDBGDebugCorePlugin.logError(t);
                      collector.worked();
                    }
                  }
                });
          } catch (Throwable e) {
            SDBGDebugCorePlugin.logError(e);
            collector.worked();
          }
        }
      }
    }

    for (WebkitScope scope : scopes) {
      if (!flattenLocalScope || !scope.isLocal()) {
        collector.createScopeVariable(scope.getObject(), scope.getType());
      }
    }

    return collector;
  }

  public static VariableCollector empty() {
    return new VariableCollector(null, 0);
  }

  public static VariableCollector fixed(WebkitDebugTarget target, List<IVariable> variables) {
    return new VariableCollector(target, variables);
  }

  public VariableCollector(WebkitDebugTarget target, List<IVariable> variables) {
    this.target = target;
    this.variables.addAll(variables);
    this.latch = new CountDownLatch(0);
  }

  private VariableCollector(WebkitDebugTarget target, int work) {
    this(target, work, null);
  }

  private VariableCollector(WebkitDebugTarget target, int work, WebkitDebugVariable parentVariable) {
    this.target = target;
    this.parentVariable = parentVariable;
    this.latch = new CountDownLatch(work);
  }

  public IVariable[] getVariables() throws InterruptedException {
    latch.await();

    return variables.toArray(new IVariable[variables.size()]);
  }

  public List<WebkitPropertyDescriptor> getWebkitProperties() throws InterruptedException {
    latch.await();

    return webkitProperties;
  }

  private void collectFields(WebkitResult<WebkitPropertyDescriptor[]> results, boolean shouldSort,
      boolean isStatic, boolean isLocal) {
    if (!results.isError()) {
      WebkitPropertyDescriptor[] properties = results.getResult();

      if (shouldSort) {
        properties = sort(properties);
      }

      webkitProperties = Arrays.asList(properties);

      for (WebkitPropertyDescriptor descriptor : properties) {
        if (descriptor.isEnumerable() || "__proto__".equals(descriptor.getName())) {
          if (!shouldFilter(descriptor)) {
            WebkitDebugVariable variable = new WebkitDebugVariable(target, descriptor);

            if (parentVariable != null) {
              variable.setParent(parentVariable);
            }

            variable.setIsStatic(isStatic);
            variable.setIsLocal(isLocal);
            variables.add(variable);
          }
        }
      }
    }

    latch.countDown();
  }

  @SuppressWarnings("unused")
  private boolean collectStaticFields(final WebkitRemoteObject classInfo, final CountDownLatch latch) {
    try {
      target.getConnection().getRuntime().getProperties(
          classInfo,
          true,
          false,
          new WebkitCallback<WebkitPropertyDescriptor[]>() {
            @Override
            public void handleResult(WebkitResult<WebkitPropertyDescriptor[]> result) {
              collectStaticFieldsResults(result, latch);
            }
          });

      return true;
    } catch (IOException e) {
      return false;
    }
  }

  private void collectStaticFieldsResults(WebkitResult<WebkitPropertyDescriptor[]> results,
      CountDownLatch latch) {
    try {
      if (!results.isError()) {
        for (WebkitPropertyDescriptor descriptor : sort(results.getResult())) {
          if (descriptor.isEnumerable()) {
            WebkitDebugVariable variable = new WebkitDebugVariable(target, descriptor);

            variable.setIsStatic(true);

            if (parentVariable != null) {
              variable.setParent(parentVariable);
            }

            variables.add(variable);
          }
        }
      }
    } finally {
      latch.countDown();
    }
  }

  private void createExceptionVariable(WebkitRemoteObject thisObject) {
    WebkitDebugVariable variable = new WebkitDebugVariable(
        target,
        WebkitPropertyDescriptor.createObjectDescriptor(thisObject, "exception"),
        true);

    variables.add(variable);
  }

//  private void createLibraryVariable(WebkitRemoteObject libraryObject) {
//    WebkitDebugVariable variable = new WebkitDebugVariable(
//        target,
//        WebkitPropertyDescriptor.createObjectDescriptor(libraryObject, DebuggerUtils.TOP_LEVEL_NAME));
//    variable.setIsLibraryObject(true);
//    variables.add(variable);
//  }

  private void createScopeVariable(WebkitRemoteObject object, String name) {
    WebkitDebugVariable variable = new WebkitDebugVariable(
        target,
        WebkitPropertyDescriptor.createObjectDescriptor(object, name),
        true);
    variables.add(variable);
  }

  private void createThisVariable(WebkitRemoteObject thisObject) {
    variables.add(new WebkitDebugVariable(target, WebkitPropertyDescriptor.createObjectDescriptor(
        thisObject,
        "this"), true));
  }

  private boolean isListNonIndex(WebkitPropertyDescriptor descriptor) {
    if (parentVariable != null && parentVariable.isListValue()) {
      try {
        Integer.parseInt(descriptor.getName());
        return false;
      } catch (NumberFormatException nfe) {
        return true;
      }
    } else {
      return false;
    }
  }

  /**
   * Some specific property filters, to make up for the fact that the enumerable property is not
   * always set correctly.
   * 
   * @param descriptor
   * @return
   */
  private boolean shouldFilter(WebkitPropertyDescriptor descriptor) {
    // array fields which are not indexes
    if (isListNonIndex(descriptor)) {
      return true;
    }

    // toString function
    if (descriptor.getValue() != null && descriptor.getValue().isFunction()) {
      if ("toString".equals(descriptor.getName())) {
        return true;
      }
    }

    return false;
  }

  private WebkitPropertyDescriptor[] sort(WebkitPropertyDescriptor[] properties) {
    Arrays.sort(properties);

    return properties;
  }

  private void worked() {
    latch.countDown();
  }

}
