module destroy_handle(
							 input [9:0] touch_edge,
							 output [9:0] des, load
							 );
	// Once a plane is destroyed, send des signal to Y coord counter and
	// send load signal to x register to load the next random coord.
	
	// Temprary assign destroy.
	assign des = touch_edge;
	
	// Assign load signal.
	assign load = des;
	
endmodule
