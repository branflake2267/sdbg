// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
// Dart test for reading escape sequences in string literals

class CharEscapeTest {
  static testMain() {
    var x00 = "\x00";
    var u0000 = "\u0000";
    var v0 = "\u{0}";
    var v00 = "\u{00}";
    var v000 = "\u{000}";
    var v0000 = "\u{0000}";
    var v00000 = "\u{00000}";
    var v000000 = "\u{000000}";
    Expect.equals(1, x00.length);
    Expect.equals(1, u0000.length);
    Expect.equals(1, v0.length);
    Expect.equals(1, v00.length);
    Expect.equals(1, v000.length);
    Expect.equals(1, v0000.length);
    Expect.equals(1, v00000.length);
    Expect.equals(1, v000000.length);
    Expect.equals(0, x00.charCodeAt(0));
    Expect.equals(0, u0000.charCodeAt(0));
    Expect.equals(0, v0.charCodeAt(0));
    Expect.equals(0, v00.charCodeAt(0));
    Expect.equals(0, v000.charCodeAt(0));
    Expect.equals(0, v0000.charCodeAt(0));
    Expect.equals(0, v00000.charCodeAt(0));
    Expect.equals(0, v000000.charCodeAt(0));
    Expect.equals("\x00", new String.fromCharCodes([0]));
    Expect.equals("\u0000", new String.fromCharCodes([0]));
    Expect.equals("\u{0}", new String.fromCharCodes([0]));
    Expect.equals("\u{00}", new String.fromCharCodes([0]));
    Expect.equals("\u{000}", new String.fromCharCodes([0]));
    Expect.equals("\u{0000}", new String.fromCharCodes([0]));
    Expect.equals("\u{00000}", new String.fromCharCodes([0]));
    Expect.equals("\u{000000}", new String.fromCharCodes([0]));

    var x01 = "\x01";
    var u0001 = "\u0001";
    var v1 = "\u{1}";
    var v01 = "\u{01}";
    var v001 = "\u{001}";
    var v0001 = "\u{0001}";
    var v00001 = "\u{00001}";
    var v000001 = "\u{000001}";
    Expect.equals(1, x01.length);
    Expect.equals(1, u0001.length);
    Expect.equals(1, v1.length);
    Expect.equals(1, v01.length);
    Expect.equals(1, v001.length);
    Expect.equals(1, v0001.length);
    Expect.equals(1, v00001.length);
    Expect.equals(1, v000001.length);
    Expect.equals(1, x01.charCodeAt(0));
    Expect.equals(1, u0001.charCodeAt(0));
    Expect.equals(1, v1.charCodeAt(0));
    Expect.equals(1, v01.charCodeAt(0));
    Expect.equals(1, v001.charCodeAt(0));
    Expect.equals(1, v0001.charCodeAt(0));
    Expect.equals(1, v00001.charCodeAt(0));
    Expect.equals(1, v000001.charCodeAt(0));
    Expect.equals("\x01", new String.fromCharCodes([1]));
    Expect.equals("\u0001", new String.fromCharCodes([1]));
    Expect.equals("\u{1}", new String.fromCharCodes([1]));
    Expect.equals("\u{01}", new String.fromCharCodes([1]));
    Expect.equals("\u{001}", new String.fromCharCodes([1]));
    Expect.equals("\u{0001}", new String.fromCharCodes([1]));
    Expect.equals("\u{00001}", new String.fromCharCodes([1]));
    Expect.equals("\u{000001}", new String.fromCharCodes([1]));

    var x55 = "\x55";
    var u0055 = "\u0055";
    var v55 = "\u{55}";
    var v055 = "\u{055}";
    var v0055 = "\u{0055}";
    var v00055 = "\u{00055}";
    var v000055 = "\u{000055}";
    Expect.equals(1, x55.length);
    Expect.equals(1, u0055.length);
    Expect.equals(1, v55.length);
    Expect.equals(1, v055.length);
    Expect.equals(1, v0055.length);
    Expect.equals(1, v00055.length);
    Expect.equals(1, v000055.length);
    Expect.equals(0x55, x55.charCodeAt(0));
    Expect.equals(0x55, u0055.charCodeAt(0));
    Expect.equals(0x55, v55.charCodeAt(0));
    Expect.equals(0x55, v055.charCodeAt(0));
    Expect.equals(0x55, v0055.charCodeAt(0));
    Expect.equals(0x55, v00055.charCodeAt(0));
    Expect.equals(0x55, v000055.charCodeAt(0));
    Expect.equals("\x55", new String.fromCharCodes([0x55]));
    Expect.equals("\u0055", new String.fromCharCodes([0x55]));
    Expect.equals("\u{55}", new String.fromCharCodes([0x55]));
    Expect.equals("\u{055}", new String.fromCharCodes([0x55]));
    Expect.equals("\u{0055}", new String.fromCharCodes([0x55]));
    Expect.equals("\u{00055}", new String.fromCharCodes([0x55]));
    Expect.equals("\u{000055}", new String.fromCharCodes([0x55]));

    var x7F = "\x7F";
    var u007F = "\u007F";
    var v7F = "\u{7F}";
    var v07F = "\u{07F}";
    var v007F = "\u{007F}";
    var v0007F = "\u{0007F}";
    var v00007F = "\u{00007F}";
    Expect.equals(1, x7F.length);
    Expect.equals(1, u007F.length);
    Expect.equals(1, v7F.length);
    Expect.equals(1, v07F.length);
    Expect.equals(1, v007F.length);
    Expect.equals(1, v0007F.length);
    Expect.equals(1, v00007F.length);
    Expect.equals(0x7F, x7F.charCodeAt(0));
    Expect.equals(0x7F, u007F.charCodeAt(0));
    Expect.equals(0x7F, v7F.charCodeAt(0));
    Expect.equals(0x7F, v07F.charCodeAt(0));
    Expect.equals(0x7F, v007F.charCodeAt(0));
    Expect.equals(0x7F, v0007F.charCodeAt(0));
    Expect.equals(0x7F, v00007F.charCodeAt(0));
    Expect.equals("\x7F", new String.fromCharCodes([0x7F]));
    Expect.equals("\u007F", new String.fromCharCodes([0x7F]));
    Expect.equals("\u{7F}", new String.fromCharCodes([0x7F]));
    Expect.equals("\u{07F}", new String.fromCharCodes([0x7F]));
    Expect.equals("\u{007F}", new String.fromCharCodes([0x7F]));
    Expect.equals("\u{0007F}", new String.fromCharCodes([0x7F]));
    Expect.equals("\u{00007F}", new String.fromCharCodes([0x7F]));

    var x80 = "\x80";
    var u0080 = "\u0080";
    var v80 = "\u{80}";
    var v080 = "\u{080}";
    var v0080 = "\u{0080}";
    var v00080 = "\u{00080}";
    var v000080 = "\u{000080}";
    Expect.equals(1, x80.length);
    Expect.equals(1, u0080.length);
    Expect.equals(1, v80.length);
    Expect.equals(1, v080.length);
    Expect.equals(1, v0080.length);
    Expect.equals(1, v00080.length);
    Expect.equals(1, v000080.length);
    Expect.equals(0x80, x80.charCodeAt(0));
    Expect.equals(0x80, u0080.charCodeAt(0));
    Expect.equals(0x80, v80.charCodeAt(0));
    Expect.equals(0x80, v080.charCodeAt(0));
    Expect.equals(0x80, v0080.charCodeAt(0));
    Expect.equals(0x80, v00080.charCodeAt(0));
    Expect.equals(0x80, v000080.charCodeAt(0));
    Expect.equals("\x80", new String.fromCharCodes([0x80]));
    Expect.equals("\u0080", new String.fromCharCodes([0x80]));
    Expect.equals("\u{80}", new String.fromCharCodes([0x80]));
    Expect.equals("\u{080}", new String.fromCharCodes([0x80]));
    Expect.equals("\u{0080}", new String.fromCharCodes([0x80]));
    Expect.equals("\u{00080}", new String.fromCharCodes([0x80]));
    Expect.equals("\u{000080}", new String.fromCharCodes([0x80]));

    var xAA = "\xAA";
    var u00AA = "\u00AA";
    var vAA = "\u{AA}";
    var v0AA = "\u{0AA}";
    var v00AA = "\u{00AA}";
    var v000AA = "\u{000AA}";
    var v0000AA = "\u{0000AA}";
    Expect.equals(1, xAA.length);
    Expect.equals(1, u00AA.length);
    Expect.equals(1, vAA.length);
    Expect.equals(1, v0AA.length);
    Expect.equals(1, v00AA.length);
    Expect.equals(1, v000AA.length);
    Expect.equals(1, v0000AA.length);
    Expect.equals(0xAA, xAA.charCodeAt(0));
    Expect.equals(0xAA, u00AA.charCodeAt(0));
    Expect.equals(0xAA, vAA.charCodeAt(0));
    Expect.equals(0xAA, v0AA.charCodeAt(0));
    Expect.equals(0xAA, v00AA.charCodeAt(0));
    Expect.equals(0xAA, v000AA.charCodeAt(0));
    Expect.equals(0xAA, v0000AA.charCodeAt(0));
    Expect.equals("\xAA", new String.fromCharCodes([0xAA]));
    Expect.equals("\u00AA", new String.fromCharCodes([0xAA]));
    Expect.equals("\u{AA}", new String.fromCharCodes([0xAA]));
    Expect.equals("\u{0AA}", new String.fromCharCodes([0xAA]));
    Expect.equals("\u{00AA}", new String.fromCharCodes([0xAA]));
    Expect.equals("\u{000AA}", new String.fromCharCodes([0xAA]));
    Expect.equals("\u{0000AA}", new String.fromCharCodes([0xAA]));

    var xFE = "\xFE";
    var u00FE = "\u00FE";
    var vFE = "\u{FE}";
    var v0FE = "\u{0FE}";
    var v00FE = "\u{00FE}";
    var v000FE = "\u{000FE}";
    var v0000FE = "\u{0000FE}";
    Expect.equals(1, xFE.length);
    Expect.equals(1, u00FE.length);
    Expect.equals(1, vFE.length);
    Expect.equals(1, v0FE.length);
    Expect.equals(1, v00FE.length);
    Expect.equals(1, v000FE.length);
    Expect.equals(1, v0000FE.length);
    Expect.equals(0xFE, xFE.charCodeAt(0));
    Expect.equals(0xFE, u00FE.charCodeAt(0));
    Expect.equals(0xFE, vFE.charCodeAt(0));
    Expect.equals(0xFE, v0FE.charCodeAt(0));
    Expect.equals(0xFE, v00FE.charCodeAt(0));
    Expect.equals(0xFE, v000FE.charCodeAt(0));
    Expect.equals(0xFE, v0000FE.charCodeAt(0));
    Expect.equals("\xFE", new String.fromCharCodes([0xFE]));
    Expect.equals("\u00FE", new String.fromCharCodes([0xFE]));
    Expect.equals("\u{FE}", new String.fromCharCodes([0xFE]));
    Expect.equals("\u{0FE}", new String.fromCharCodes([0xFE]));
    Expect.equals("\u{00FE}", new String.fromCharCodes([0xFE]));
    Expect.equals("\u{000FE}", new String.fromCharCodes([0xFE]));
    Expect.equals("\u{0000FE}", new String.fromCharCodes([0xFE]));

    var xFF = "\xFF";
    var u00FF = "\u00FF";
    var vFF = "\u{FF}";
    var v0FF = "\u{0FF}";
    var v00FF = "\u{00FF}";
    var v000FF = "\u{000FF}";
    var v0000FF = "\u{0000FF}";
    Expect.equals(1, xFF.length);
    Expect.equals(1, u00FF.length);
    Expect.equals(1, vFF.length);
    Expect.equals(1, v0FF.length);
    Expect.equals(1, v00FF.length);
    Expect.equals(1, v000FF.length);
    Expect.equals(1, v0000FF.length);
    Expect.equals(0xFF, xFF.charCodeAt(0));
    Expect.equals(0xFF, u00FF.charCodeAt(0));
    Expect.equals(0xFF, vFF.charCodeAt(0));
    Expect.equals(0xFF, v0FF.charCodeAt(0));
    Expect.equals(0xFF, v00FF.charCodeAt(0));
    Expect.equals(0xFF, v000FF.charCodeAt(0));
    Expect.equals(0xFF, v0000FF.charCodeAt(0));
    Expect.equals("\xFF", new String.fromCharCodes([0xFF]));
    Expect.equals("\u00FF", new String.fromCharCodes([0xFF]));
    Expect.equals("\u{FF}", new String.fromCharCodes([0xFF]));
    Expect.equals("\u{0FF}", new String.fromCharCodes([0xFF]));
    Expect.equals("\u{00FF}", new String.fromCharCodes([0xFF]));
    Expect.equals("\u{000FF}", new String.fromCharCodes([0xFF]));
    Expect.equals("\u{0000FF}", new String.fromCharCodes([0xFF]));

    var u1000 = "\u1000";
    var v1000 = "\u{1000}";
    var v01000 = "\u{01000}";
    var v001000 = "\u{001000}";
    Expect.equals(1, u1000.length);
    Expect.equals(1, v1000.length);
    Expect.equals(1, v01000.length);
    Expect.equals(1, v001000.length);
    Expect.equals(0x1000, u1000.charCodeAt(0));
    Expect.equals(0x1000, v1000.charCodeAt(0));
    Expect.equals(0x1000, v01000.charCodeAt(0));
    Expect.equals(0x1000, v001000.charCodeAt(0));
    Expect.equals("\u1000", new String.fromCharCodes([0x1000]));
    Expect.equals("\u{1000}", new String.fromCharCodes([0x1000]));
    Expect.equals("\u{01000}", new String.fromCharCodes([0x1000]));
    Expect.equals("\u{001000}", new String.fromCharCodes([0x1000]));

    var u5555 = "\u5555";
    var v5555 = "\u{5555}";
    var v05555 = "\u{05555}";
    var v005555 = "\u{005555}";
    Expect.equals(1, u5555.length);
    Expect.equals(1, v5555.length);
    Expect.equals(1, v05555.length);
    Expect.equals(1, v005555.length);
    Expect.equals(0x5555, u5555.charCodeAt(0));
    Expect.equals(0x5555, v5555.charCodeAt(0));
    Expect.equals(0x5555, v05555.charCodeAt(0));
    Expect.equals(0x5555, v005555.charCodeAt(0));
    Expect.equals("\u5555", new String.fromCharCodes([0x5555]));
    Expect.equals("\u{5555}", new String.fromCharCodes([0x5555]));
    Expect.equals("\u{05555}", new String.fromCharCodes([0x5555]));
    Expect.equals("\u{005555}", new String.fromCharCodes([0x5555]));

    var u7FFF = "\u7FFF";
    var v7FFF = "\u{7FFF}";
    var v07FFF = "\u{07FFF}";
    var v007FFF = "\u{007FFF}";
    Expect.equals(1, u7FFF.length);
    Expect.equals(1, v7FFF.length);
    Expect.equals(1, v07FFF.length);
    Expect.equals(1, v007FFF.length);
    Expect.equals(0x7FFF, u7FFF.charCodeAt(0));
    Expect.equals(0x7FFF, v7FFF.charCodeAt(0));
    Expect.equals(0x7FFF, v07FFF.charCodeAt(0));
    Expect.equals(0x7FFF, v007FFF.charCodeAt(0));
    Expect.equals("\u7FFF", new String.fromCharCodes([0x7FFF]));
    Expect.equals("\u{7FFF}", new String.fromCharCodes([0x7FFF]));
    Expect.equals("\u{07FFF}", new String.fromCharCodes([0x7FFF]));
    Expect.equals("\u{007FFF}", new String.fromCharCodes([0x7FFF]));

    var u8000 = "\u8000";
    var v8000 = "\u{8000}";
    var v08000 = "\u{08000}";
    var v008000 = "\u{008000}";
    Expect.equals(1, u8000.length);
    Expect.equals(1, v8000.length);
    Expect.equals(1, v08000.length);
    Expect.equals(1, v008000.length);
    Expect.equals(0x8000, u8000.charCodeAt(0));
    Expect.equals(0x8000, v8000.charCodeAt(0));
    Expect.equals(0x8000, v08000.charCodeAt(0));
    Expect.equals(0x8000, v008000.charCodeAt(0));
    Expect.equals("\u8000", new String.fromCharCodes([0x8000]));
    Expect.equals("\u{8000}", new String.fromCharCodes([0x8000]));
    Expect.equals("\u{08000}", new String.fromCharCodes([0x8000]));
    Expect.equals("\u{008000}", new String.fromCharCodes([0x8000]));

    var uAAAA = "\uAAAA";
    var vAAAA = "\u{AAAA}";
    var v0AAAA = "\u{0AAAA}";
    var v00AAAA = "\u{00AAAA}";
    Expect.equals(1, uAAAA.length);
    Expect.equals(1, vAAAA.length);
    Expect.equals(1, v0AAAA.length);
    Expect.equals(1, v00AAAA.length);
    Expect.equals(0xAAAA, uAAAA.charCodeAt(0));
    Expect.equals(0xAAAA, vAAAA.charCodeAt(0));
    Expect.equals(0xAAAA, v0AAAA.charCodeAt(0));
    Expect.equals(0xAAAA, v00AAAA.charCodeAt(0));
    Expect.equals("\uAAAA", new String.fromCharCodes([0xAAAA]));
    Expect.equals("\u{AAAA}", new String.fromCharCodes([0xAAAA]));
    Expect.equals("\u{0AAAA}", new String.fromCharCodes([0xAAAA]));
    Expect.equals("\u{00AAAA}", new String.fromCharCodes([0xAAAA]));

    var uFFFE = "\uFFFE";
    var vFFFE = "\u{FFFE}";
    var v0FFFE = "\u{0FFFE}";
    var v00FFFE = "\u{00FFFE}";
    Expect.equals(1, uFFFE.length);
    Expect.equals(1, vFFFE.length);
    Expect.equals(1, v0FFFE.length);
    Expect.equals(1, v00FFFE.length);
    Expect.equals(0xFFFE, uFFFE.charCodeAt(0));
    Expect.equals(0xFFFE, vFFFE.charCodeAt(0));
    Expect.equals(0xFFFE, v0FFFE.charCodeAt(0));
    Expect.equals(0xFFFE, v00FFFE.charCodeAt(0));
    Expect.equals("\uFFFE", new String.fromCharCodes([0xFFFE]));
    Expect.equals("\u{FFFE}", new String.fromCharCodes([0xFFFE]));
    Expect.equals("\u{0FFFE}", new String.fromCharCodes([0xFFFE]));
    Expect.equals("\u{00FFFE}", new String.fromCharCodes([0xFFFE]));

    var uFFFF = "\uFFFF";
    var vFFFF = "\u{FFFF}";
    var v0FFFF = "\u{0FFFF}";
    var v00FFFF = "\u{00FFFF}";
    Expect.equals(1, uFFFF.length);
    Expect.equals(1, vFFFF.length);
    Expect.equals(1, v0FFFF.length);
    Expect.equals(1, v00FFFF.length);
    Expect.equals(0xFFFF, uFFFF.charCodeAt(0));
    Expect.equals(0xFFFF, vFFFF.charCodeAt(0));
    Expect.equals(0xFFFF, v0FFFF.charCodeAt(0));
    Expect.equals(0xFFFF, v00FFFF.charCodeAt(0));
    Expect.equals("\uFFFF", new String.fromCharCodes([0xFFFF]));
    Expect.equals("\u{FFFF}", new String.fromCharCodes([0xFFFF]));
    Expect.equals("\u{0FFFF}", new String.fromCharCodes([0xFFFF]));
    Expect.equals("\u{00FFFF}", new String.fromCharCodes([0xFFFF]));

    var v10000 = "\u{10000}";
    var v010000 = "\u{010000}";
    Expect.equals(2, v10000.length);
    Expect.equals(2, v010000.length);
    Expect.equals("\u{10000}", new String.fromCharCodes([0x10000]));
    Expect.equals("\u{010000}", new String.fromCharCodes([0x10000]));

    var v1FFFF = "\u{1FFFF}";
    var v01FFFF = "\u{01FFFF}";
    Expect.equals(2, v1FFFF.length);
    Expect.equals(2, v01FFFF.length);
    Expect.equals("\u{1FFFF}", new String.fromCharCodes([0x1FFFF]));
    Expect.equals("\u{01FFFF}", new String.fromCharCodes([0x1FFFF]));

    var v105555 = "\u{105555}";
    Expect.equals(2, v105555.length);
    Expect.equals("\u{105555}", new String.fromCharCodes([0x105555]));

    var v10FFFF = "\u{10FFFF}";
    Expect.equals(2, v10FFFF.length);
    Expect.equals("\u{10FFFF}", new String.fromCharCodes([0x10FFFF]));

    var bs = "\b";
    Expect.isTrue(bs != "b");
    Expect.equals(1, bs.length);
    Expect.equals(0x08, bs.charCodeAt(0));
    Expect.equals(bs, new String.fromCharCodes([0x08]));
    Expect.equals("\x08", bs);
    Expect.equals("\u0008", bs);
    Expect.equals("\u{8}", bs);
    Expect.equals("\u{08}", bs);
    Expect.equals("\u{008}", bs);
    Expect.equals("\u{0008}", bs);
    Expect.equals("\u{00008}", bs);
    Expect.equals("\u{000008}", bs);

    var ht = "\t";
    Expect.isTrue(ht != "t");
    Expect.equals(1, ht.length);
    Expect.equals(0x09, ht.charCodeAt(0));
    Expect.equals(ht, new String.fromCharCodes([0x09]));
    Expect.equals("\x09", ht);
    Expect.equals("\u0009", ht);
    Expect.equals("\u{9}", ht);
    Expect.equals("\u{09}", ht);
    Expect.equals("\u{009}", ht);
    Expect.equals("\u{0009}", ht);
    Expect.equals("\u{00009}", ht);
    Expect.equals("\u{000009}", ht);

    var lf = "\n";
    Expect.isTrue(lf != "n");
    Expect.equals(1, lf.length);
    Expect.equals(0x0A, lf.charCodeAt(0));
    Expect.equals(lf, new String.fromCharCodes([0x0A]));
    Expect.equals("\x0A", lf);
    Expect.equals("\u000A", lf);
    Expect.equals("\u{A}", lf);
    Expect.equals("\u{0A}", lf);
    Expect.equals("\u{00A}", lf);
    Expect.equals("\u{000A}", lf);
    Expect.equals("\u{0000A}", lf);
    Expect.equals("\u{00000A}", lf);

    var vt = "\v";
    Expect.isTrue(vt != "v");
    Expect.equals(1, vt.length);
    Expect.equals(0x0B, vt.charCodeAt(0));
    Expect.equals(vt, new String.fromCharCodes([0x0B]));
    Expect.equals("\x0B", vt);
    Expect.equals("\u000B", vt);
    Expect.equals("\u{B}", vt);
    Expect.equals("\u{0B}", vt);
    Expect.equals("\u{00B}", vt);
    Expect.equals("\u{000B}", vt);
    Expect.equals("\u{0000B}", vt);
    Expect.equals("\u{00000B}", vt);

    var ff = "\f";
    Expect.isTrue(ff != "f");
    Expect.equals(1, ff.length);
    Expect.equals(0x0C, ff.charCodeAt(0));
    Expect.equals(ff, new String.fromCharCodes([0x0C]));
    Expect.equals("\x0C", ff);
    Expect.equals("\u000C", ff);
    Expect.equals("\u{C}", ff);
    Expect.equals("\u{0C}", ff);
    Expect.equals("\u{00C}", ff);
    Expect.equals("\u{000C}", ff);
    Expect.equals("\u{0000C}", ff);
    Expect.equals("\u{00000C}", ff);

    var cr = "\r";
    Expect.isTrue(cr != "r");
    Expect.equals(1, cr.length);
    Expect.equals(0x0D, cr.charCodeAt(0));
    Expect.equals(cr, new String.fromCharCodes([0x0D]));
    Expect.equals("\x0D", cr);
    Expect.equals("\u000D", cr);
    Expect.equals("\u{D}", cr);
    Expect.equals("\u{0D}", cr);
    Expect.equals("\u{00D}", cr);
    Expect.equals("\u{000D}", cr);
    Expect.equals("\u{0000D}", cr);
    Expect.equals("\u{00000D}", cr);

    Expect.equals("\a", "a");
    // \b U+0006 BS
    Expect.equals("\c", "c");
    Expect.equals("\d", "d");
    Expect.equals("\e", "e");
    // \f U+000C FF
    Expect.equals("\g", "g");
    Expect.equals("\h", "h");
    Expect.equals("\i", "i");
    Expect.equals("\j", "j");
    Expect.equals("\k", "k");
    Expect.equals("\l", "l");
    Expect.equals("\m", "m");
    // \n U+000A LF
    Expect.equals("\o", "o");
    Expect.equals("\p", "p");
    Expect.equals("\q", "q");
    // \r U+000D CR
    Expect.equals("\s", "s");
    // \t U+0009 HT
    // \u code point escape
    // \v U+000B VT
    Expect.equals("\w", "w");
    // \x code point escape
    Expect.equals("\y", "y");
    Expect.equals("\z", "z");

    Expect.equals("\A", "A");
    Expect.equals("\B", "B");
    Expect.equals("\C", "C");
    Expect.equals("\D", "D");
    Expect.equals("\E", "E");
    Expect.equals("\F", "F");
    Expect.equals("\G", "G");
    Expect.equals("\H", "H");
    Expect.equals("\I", "I");
    Expect.equals("\J", "J");
    Expect.equals("\K", "K");
    Expect.equals("\L", "L");
    Expect.equals("\M", "M");
    Expect.equals("\N", "N");
    Expect.equals("\O", "O");
    Expect.equals("\P", "P");
    Expect.equals("\Q", "Q");
    Expect.equals("\R", "R");
    Expect.equals("\S", "S");
    Expect.equals("\T", "T");
    Expect.equals("\U", "U");
    Expect.equals("\V", "V");
    Expect.equals("\W", "W");
    Expect.equals("\X", "X");
    Expect.equals("\Y", "Y");
    Expect.equals("\Z", "Z");
  }
}

main() {
  CharEscapeTest.testMain();
}
