// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../sdk/lib/_internal/compiler/implementation/dart2jslib.dart' show
    DualKind,
    MessageKind;

import 'message_kind_helper.dart';

import 'dart:mirrors';

main() {
  ClassMirror cls = reflectClass(MessageKind);
  Map<String, MessageKind> kinds = <String, MessageKind>{};
  cls.variables.forEach((Symbol name, VariableMirror variable) {
    if (variable.isStatic) {
      var value = cls.getField(name).reflectee;
      if (value is MessageKind) {
        kinds[MirrorSystem.getName(name)] = value;
      } else if (value is DualKind) {
        kinds['${MirrorSystem.getName(name)}.error'] = value.error;
        kinds['${MirrorSystem.getName(name)}.warning'] = value.warning;
      } else {
        Expect.fail("Weird static field: '${MirrorSystem.getName(name)}'.");
      }
    }
  });
  List<String> names = kinds.keys.toList()..sort();
  List<String> examples = <String>[];
  for (String name in names) {
    MessageKind kind = kinds[name];
    if (name == 'GENERIC' // Shouldn't be used.
        // We can't provoke a crash.
        || name == 'COMPILER_CRASHED'
        || name == 'PLEASE_REPORT_THE_CRASH'
        // We cannot provide examples for patch errors.
        || name.startsWith('PATCH_')) continue;
    if (kind.examples != null) {
      examples.add(name);
    } else {
      print("No example in '$name'");
    }
  };
  var cachedCompiler;
  for (String name in examples) {
    Stopwatch sw = new Stopwatch()..start();
    cachedCompiler = check(kinds[name], cachedCompiler);
    sw.stop();
    print("Checked '$name' in ${sw.elapsedMilliseconds}ms.");
  }
}