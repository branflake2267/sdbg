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
package com.google.dart.engine.internal.type;

import com.google.dart.engine.element.TypeParameterElement;
import com.google.dart.engine.type.Type;
import com.google.dart.engine.type.TypeParameterType;
import com.google.dart.engine.utilities.general.ObjectUtilities;

/**
 * Instances of the class {@code TypeParameterTypeImpl} defines the behavior of objects representing
 * the type introduced by a type parameter.
 * 
 * @coverage dart.engine.type
 */
public class TypeParameterTypeImpl extends TypeImpl implements TypeParameterType {
  /**
   * An empty array of type parameter types.
   */
  public static final TypeParameterType[] EMPTY_ARRAY = new TypeParameterType[0];

  /**
   * Return an array containing the type parameter types defined by the given array of type
   * parameter elements.
   * 
   * @param typeParameters the type parameter elements defining the type parameter types to be
   *          returned
   * @return the type parameter types defined by the type parameter elements
   */
  public static TypeParameterType[] getTypes(TypeParameterElement[] typeParameters) {
    int count = typeParameters.length;
    if (count == 0) {
      return EMPTY_ARRAY;
    }
    TypeParameterType[] types = new TypeParameterType[count];
    for (int i = 0; i < count; i++) {
      types[i] = typeParameters[i].getType();
    }
    return types;
  }

  /**
   * Initialize a newly created type parameter type to be declared by the given element and to have
   * the given name.
   * 
   * @param element the element representing the declaration of the type parameter
   */
  public TypeParameterTypeImpl(TypeParameterElement element) {
    super(element, element.getName());
  }

  @Override
  public boolean equals(Object object) {
    return object instanceof TypeParameterTypeImpl
        && ObjectUtilities.equals(getElement(), ((TypeParameterTypeImpl) object).getElement());
  }

  @Override
  public TypeParameterElement getElement() {
    return (TypeParameterElement) super.getElement();
  }

  @Override
  public int hashCode() {
    return getElement().hashCode();
  }

  @Override
  public boolean isMoreSpecificThan(Type type) {
    //
    // T is a type parameter and S is the upper bound of T.
    //
    Type upperBound = getElement().getBound();
    return type.equals(upperBound);
  }

  @Override
  public boolean isSubtypeOf(Type type) {
    // TODO(scheglov) really? without checking if this is another type parameter and bound?
    return true;
  }

  @Override
  public Type substitute(Type[] argumentTypes, Type[] parameterTypes) {
    int length = parameterTypes.length;
    for (int i = 0; i < length; i++) {
      if (parameterTypes[i].equals(this)) {
        return argumentTypes[i];
      }
    }
    return this;
  }
}