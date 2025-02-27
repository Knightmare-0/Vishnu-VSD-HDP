/* Generated by Yosys 0.9 (git sha1 1979e0b) */

module bidcounter(count, clk, ctrl, reset);
  wire [3:0] _00_;
  wire _01_;
  wire _02_;
  wire _03_;
  wire _04_;
  wire _05_;
  wire _06_;
  wire _07_;
  wire _08_;
  wire _09_;
  wire _10_;
  wire _11_;
  wire _12_;
  wire _13_;
  wire _14_;
  wire _15_;
  wire _16_;
  wire _17_;
  wire _18_;
  wire _19_;
  wire _20_;
  wire _21_;
  wire _22_;
  wire _23_;
  wire _24_;
  wire _25_;
  wire _26_;
  wire _27_;
  wire _28_;
  wire _29_;
  wire _30_;
  wire _31_;
  wire _32_;
  wire _33_;
  wire _34_;
  wire _35_;
  wire _36_;
  wire _37_;
  input clk;
  output [3:0] count;
  input ctrl;
  input reset;
  sky130_fd_sc_hd__clkinv_1 _38_ (
    .A(_25_),
    .Y(_27_)
  );
  sky130_fd_sc_hd__nor2_1 _39_ (
    .A(_22_),
    .B(_37_),
    .Y(_18_)
  );
  sky130_fd_sc_hd__nand2_1 _40_ (
    .A(_22_),
    .B(_23_),
    .Y(_28_)
  );
  sky130_fd_sc_hd__o21ba_1 _41_ (
    .A1(_22_),
    .A2(_23_),
    .B1_N(_26_),
    .X(_29_)
  );
  sky130_fd_sc_hd__xnor2_1 _42_ (
    .A(_22_),
    .B(_23_),
    .Y(_30_)
  );
  sky130_fd_sc_hd__a221oi_1 _43_ (
    .A1(_28_),
    .A2(_29_),
    .B1(_30_),
    .B2(_26_),
    .C1(_37_),
    .Y(_19_)
  );
  sky130_fd_sc_hd__a21boi_0 _44_ (
    .A1(_22_),
    .A2(_23_),
    .B1_N(_26_),
    .Y(_31_)
  );
  sky130_fd_sc_hd__o21ai_0 _45_ (
    .A1(_29_),
    .A2(_31_),
    .B1(_24_),
    .Y(_32_)
  );
  sky130_fd_sc_hd__or3_1 _46_ (
    .A(_24_),
    .B(_29_),
    .C(_31_),
    .X(_33_)
  );
  sky130_fd_sc_hd__a21oi_1 _47_ (
    .A1(_32_),
    .A2(_33_),
    .B1(_37_),
    .Y(_20_)
  );
  sky130_fd_sc_hd__xor2_1 _48_ (
    .A(_26_),
    .B(_24_),
    .X(_34_)
  );
  sky130_fd_sc_hd__nor4_1 _49_ (
    .A(_27_),
    .B(_29_),
    .C(_31_),
    .D(_34_),
    .Y(_35_)
  );
  sky130_fd_sc_hd__o31ai_1 _50_ (
    .A1(_29_),
    .A2(_31_),
    .A3(_34_),
    .B1(_27_),
    .Y(_36_)
  );
  sky130_fd_sc_hd__nor3b_1 _51_ (
    .A(_37_),
    .B(_35_),
    .C_N(_36_),
    .Y(_21_)
  );
  sky130_fd_sc_hd__dfxtp_1 _52_ (
    .CLK(clk),
    .D(_00_[0]),
    .Q(count[0])
  );
  sky130_fd_sc_hd__dfxtp_1 _53_ (
    .CLK(clk),
    .D(_00_[1]),
    .Q(count[1])
  );
  sky130_fd_sc_hd__dfxtp_1 _54_ (
    .CLK(clk),
    .D(_00_[2]),
    .Q(count[2])
  );
  sky130_fd_sc_hd__dfxtp_1 _55_ (
    .CLK(clk),
    .D(_00_[3]),
    .Q(count[3])
  );
  assign _22_ = count[0];
  assign _26_ = ctrl;
  assign _37_ = reset;
  assign _00_[0] = _18_;
  assign _23_ = count[1];
  assign _00_[1] = _19_;
  assign _24_ = count[2];
  assign _00_[2] = _20_;
  assign _25_ = count[3];
  assign _00_[3] = _21_;
endmodule
