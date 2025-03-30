% ============================================
% Dataset for: Knowledge Representation and Reasoning in the Context of Automated Production Planning
% Authors: Harkiran Sahota, Adam Klodowski
% Journal: Journal of Intelligent Manufacturing
% Submission Date: 30.03.2025
% ============================================
% Description:
% This file contains exemplary results from the study described in the paper
% "Knowledge Representation and Reasoning in the Context of Automated Production Planning". 
% The data presented here was used to generate exemplary results on the example of the 
% PUBLIC Bikes Sprout children’s bike and supports the findings discussed in Section [5.2] of the manuscript.
%
% Usage Instructions:
% This data is intended to be used with Clingo, an open-source Answer Set Programming (ASP) solver.
% To generate results, copy and paste the content of this file into Clingo.
% Clingo is available online at: https://potassco.org/clingo/
% Alternatively, you can install Clingo locally following the instructions at: https://github.com/potassco/clingo
%
% Data Format:
% The data represents assembly rules and facts in Answer Set Programming (ASP) format  
%
% Contact:
% For any questions regarding this dataset, please contact:
% Harkiran.Sahota@daimlertruck.com, Adam.Klodowski@lut.fi
%
% ============================================

% ASP rules defining different assembly actions and further refinements of the actions
position(Component_a) :-
	screw(Component_a,Position_x,Screw_x) ,
	screw(Component_b,Position_x,Screw_x) .
	

position_with(Component_a, "carrier") :-
	position(Component_a,Position_x), 
	component(Component_a,_,Size_a),
	100<=Size_a .

position_with(Component_a, "two workers") :-
	position(Component_a,Position_x), component(Component_a,_,Size_a),
	10<=Size_a, Size_a<100 .

position_with(Component_a, "hand") :-
	position(Component_a,Position_x), 
	component(Component_a,_,Size_a),
	10>Size_a.


screw(Component_a,Position_x,Screw_x) :-
	has_screw_hole(Component_a,Position_x),
	has_screw(Position_x, Screw_x) .
	
position(Bolt_x,"place washer",Quantity):-
    screw(_,_,Bolt_x), 
    has_washer(Bolt_x,Quantity).
    


tighten_with(Component_a,Tool_x) :-
	screw(Component_a,_,Screw_1), 
	screw_type(Screw_1,Type_x),
	tool(Tool_x, Type_x) .


plug_in(Component_a,Position_a) :-
	clip_component(Component_a),
	component(Component_a,Position_a,Size_a) .

unscrew(Bolt_x, Position_x) :-
screw(Bolt_x,Position_x) ,
pre_positioned(Component_a,Bolt_X,Position_x) .

hint("hold washer",Quantity):-
unscrew(Bolt_x, _), has_washer(Bolt_x,Quantity).

unscrew_with(Bolt_x, Position_x, "wrench", SIZE) :-
unscrew(Bolt_x,Position_x) ,
component(Bolt_x,SIZE) .

adjust(Component_a) :-
adjust_component(Component_a) ,
position(Component_a,Position_x) ,
screw_loosely(Component_a,Position_x,Screw_x) .

loosen_screw(Screw_s,Position_x) :-
clamp_connection(Component_a,Component_b,Clamp_c) ,
clamp_component(Clamp_c,Screw_s,Position_x) .

tighten_fully(Screw_s,Position_x) :-
clamp_connection(Component_a,Component_b,Clamp_c) ,
loosen_screw(Screw_s,Position_x) ,
position(Component_b).

screw_in(Component_a,Component_b,Position_x) :-
has_thread(Component_a,Position_x) ,
screw_connection(Component_a,Component_b) .

insert(Component_a,Component_b,Position_x) :-
stick_connection(Component_a,Component_b,Position_x) .

% ASP facts describing the product to be assembled:
component(fork,pos_a,size_a) .
component(fender,pos_b,size_b) .
component(brace_left,pos_cl,size_c) .
component(brace_right,pos_cr,size_c) .
component(bolt_x,"10mm") .
component(bolt_y_left,"4mm") .
component(bolt_y_right,"4mm") .

screw(fork,pos_a,bolt_x) ,
screw(fender,pos_a,bolt_x) .

screw(fork,pos_b,bolt_y) ,
screw(brace_left,pos_b,bolt_y) .

screw(fork,pos_c,bolt_y) ,
screw(brace_right,pos_c,bolt_y) .

screw(bolt_x,pos_a) .
has_washer(bolt_x,"2x") .
screw(bolt_y_left,pos_b_left). 
screw(bolt_y_right,pos_b_right). 

pre_positioned(frame,bolt_x,pos_a) .
pre_positioned(frame,bolt_y_left,pos_b_left) .
pre_positioned(frame,bolt_y_right,pos_b_right) .


% result generted using the open source anser set solver clingo by Potassco:
% has_washer(bolt_x,"2x") 
% component(fork,pos_a,size_a) 
% component(fender,pos_b,size_b) 
% component(brace_left,pos_cl,size_c) 
% component(brace_right,pos_cr,size_c) 
% pre_positioned(frame,bolt_x,pos_a) 
% pre_positioned(frame,bolt_y_left,pos_b_left) 
% pre_positioned(frame,bolt_y_right,pos_b_right) 
% screw(bolt_x,pos_a) 
% screw(bolt_y_left,pos_b_left) 
% screw(bolt_y_right,pos_b_right) 
% unscrew(bolt_x,pos_a) 
% unscrew(bolt_y_left,pos_b_left) 
% unscrew(bolt_y_right,pos_b_right) 
% hint("hold washer","2x") 
% component(bolt_x,"10mm") 
% component(bolt_y_left,"4mm") 
% component(bolt_y_right,"4mm") 
% unscrew_with(bolt_x,pos_a,"wrench","10mm") 
% unscrew_with(bolt_y_left,pos_b_left,"wrench","4mm") 
% unscrew_with(bolt_y_right,pos_b_right,"wrench","4mm") 
% screw(fork,pos_a,bolt_x) 
% screw(brace_left,pos_b,bolt_y) 
% screw(brace_right,pos_c,bolt_y) 
% position(fork) 
% position(brace_left) 
% position(brace_right) 
% position(bolt_x,"place washer","2x")



