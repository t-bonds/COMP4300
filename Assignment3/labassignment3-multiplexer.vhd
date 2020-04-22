--Author: 	Tanner Bonds
--Due Date:	3/20/2020
--Assignment Three

library work;
use work.bv_arithmetic.all;
use work.dlx_types.all;

entity mux is
	generic(propagation : Time := 5 ns);
	port(input_1, input_0 : in dlx_word;
		which: in bit; 
		output: out dlx_word);
end entity mux;

architecture behavior of mux is
begin
	process (input_1, input_0, which) is
	begin
		if which = '0' then
			output <= input_0 after propagation;
		else
			output <= input_1 after propagation;
		end if;
	end process;
end architecture behavior;
		  
