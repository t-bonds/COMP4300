--Author: 	Tanner Bonds
--Due Date:	3/20/2020
--Assignment Three

library work;
use work.bv_arithmetic.all;
use work.dlx_types.all;

entity pcplusone is
	generic(propagation: time:= 5 ns);
	port(input: in dlx_word;
		clock: in bit;
		output: out dlx_word);
end entity pcplusone;

architecture behavior of pcplusone is
begin
	process(input, clock) is
	variable newpcplus: dlx_word;
	variable error: boolean;
	begin
		if clock 'event and clock = '1' then
			bv_addu(input,
				"00000000000000000000000000000001",
				newpcplus,
				error);
				output <= newpcplus after propagation;
		end if;
	end process;
end architecture;