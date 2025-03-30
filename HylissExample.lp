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
% IKEA Hyliss shelf and supports the findings discussed in Section [5.1] of the manuscript.
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

tighten_with(Component_a,Tool_x) :-
	screw(Component_a,_,Screw_1), 
	screw_type(Screw_1,Type_x),
	tool(Tool_x, Type_x) .


plug_in(Component_a,Position_a) :-
	clip_component(Component_a),
	component(Component_a,Position_a,Size_a) .

% ASP facts describing the product to be assembled:
component(shelf1,pos_s1,10) .
component(leg1,pos_l1,15) .
component(stand1,pos_st1,3) .
screw_type(screw_1, type_a) .
tool("Phillips Screw Driver",type_a) .
clip_component(stand1).
screw(shelf1,pos_screw1,screw_1).
screw(leg1,pos_screw1,screw_1).

% result generted using the open source anser set solver clingo by Potassco:
% screw(shelf1,pos_screw1,screw_1) 
% screw(leg1,pos_screw1,screw_1) 
% position(shelf1) 
% position(leg1) 
% tool("Phillips Screw Driver",type_a) 
% screw_type(screw_1,type_a) 
% tighten_with(shelf1,"Phillips Screw Driver") 
% tighten_with(leg1,"Phillips Screw Driver") 
% component(shelf1,pos_s1,10) 
% component(leg1,pos_l1,15) 
% component(stand1,pos_st1,3) 
% clip_component(stand1) 
% plug_in(stand1,pos_st1)
