--Author: 	Tanner Bonds
--Due Date:	3/20/2020
--Assignment Three

library work;
use work.bv_arithmetic.all;
use work.dlx_types.all;

entity dlx_register is
	generic(propagation: time := 10 ns);
	port(in_val: in dlx_word; clock: in bit; out_val: out dlx_word);
end entity dlx_register;

architecture data of dlx_register is
begin
	process(in_val, clock)
	begin
		if clock = '1' then
			out_val <= in_val after propagation;
		end if;
	end process;
end architecture;
 