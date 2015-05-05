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
package com.github.sdbg.debug.ui.internal.actions;

import com.github.sdbg.debug.core.model.ISDBGValue;

import org.eclipse.debug.core.DebugException;
import org.eclipse.debug.core.model.IValue;
import org.eclipse.debug.core.model.IVariable;
import org.eclipse.jface.viewers.Viewer;

/**
 * Viewer filter action for function variables
 */
public class FunctionVariablesFilterAction extends ViewFilterAction {
  public FunctionVariablesFilterAction() {
  }

  @Override
  public boolean select(Viewer viewer, Object parentElement, Object element) {
    try {
      return select(element instanceof IVariable ? ((IVariable) element).getValue() : null);
    } catch (DebugException e) {
      throw new RuntimeException(e);
    }
  }

  protected boolean select(IValue value) {
    if (!getValue()) {
      if (value instanceof ISDBGValue) {
        ISDBGValue sval = (ISDBGValue) value;
        return !sval.isFunction();
      }
    }

    return true;
  }
}
