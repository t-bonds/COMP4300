--Author: 	Tanner Bonds
--Due Date:	02/04/2020
--Assignment One


entity XNORGate is
	generic(prop_delay: Time := 10 ns);
	port(a_in, b_in : in bit;
             result: out bit);
end entity XNORGate;

architecture behaviour of XNORGate is
begin

	XNORGateProcess : process (a_in, b_in) is
	begin
		if a_in = '1' then
			-- 1 & 1 = 1
			if b_in = '1' then
				result <= '1' after prop_delay;
			else
				-- 1 & 0 = 0 
				result <= '0' after prop_delay;
			end if;
 		else
			-- 0 & 1 = 0
			if b_in = '1' then
				result <= '0' after prop_delay;
			else
				-- 0 & 0 = 1
				result <= '1' after prop_delay;
			end if;
		end if;
	end process XNORGateProcess;
end architecture behaviour;

