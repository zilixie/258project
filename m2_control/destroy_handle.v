module destroy_handle(
							 input [9:0] touch_edge,
							 output [9:0] des, load_x
							 );
	// Once a plane is destroyed, send des signal to Y coord counter and
	// send load_x signal to x register to load the next random coord.
	
	// Temprary assign destroy.
	assign des = touch_edge;
	
	// Assign load_x signal.
	assign load_x = des;
	
endmodule
