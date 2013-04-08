// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

@lazy import 'deferred_class_library.dart';

const lazy = const DeferredLibrary('deferred_class_library');

class Expect {
  static void isTrue(x) => Expect.equals(true, x);
  static void isFalse(x) => Expect.equals(false, x);

  static void equals(expected, actual) {
    if (expected != actual) {
      throw "Not equal. Expected: $expected. Got: $actual";
    }
  }

  static void throws(fun, [test]) {
    try {
      fun();
    } catch (e) {
      if (!test(e)) throw "doesn't satisfy exception test";
      return;
    }
    throw "didn't throw";
  }

  static void isNull(x) => Expect.equals(null, x);
}

main() {
  var x;
  // TODO(ahe): What are the semantics of this:
  // x = const MyClass();
  Expect.isNull(x);
  int counter = 0;
  lazy.load().then((bool didLoad) {
    Expect.isTrue(didLoad);
    Expect.equals(1, ++counter);
    print('deferred_class_library was loaded');
    x = const MyClass();
    Expect.equals(42, x.foo(87));
  });
  Expect.equals(0, counter);
  Expect.isNull(x);
  lazy.load().then((bool didLoad) {
    Expect.isFalse(didLoad);
    Expect.equals(2, ++counter);
    print('deferred_class_library was loaded');
    x = const MyClass();
    Expect.equals(42, x.foo(87));
  });
  Expect.equals(0, counter);
  Expect.isNull(x);
  // TODO(ahe): What are the semantics of this:
  // x = const MyClass();
  Expect.isNull(x);
}
