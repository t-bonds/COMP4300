--Author: 	Tanner Bonds
--Due Date:	2/21/2020
--Assignment Two

library work;
use work.bv_arithmetic.all;
use work.dlx_types.all;

entity alu is
	generic(prop_delay: Time := 15 ns); 
	port(operand1, operand2: in dlx_word; 
	operation: in alu_operation_code;  
	result: out dlx_word; 
	error: out error_code); 
end entity alu;

architecture behaviour of alu is
	begin process (operand1, operand2, operation)
		variable overflow: boolean;
		variable zero: boolean;	
		variable logic1: boolean := false;
		variable logic2: boolean := false;
		variable inputResult: dlx_word := x"00000000";
		begin case operation is
		
			--Unsigned Add
			when "0000" => error <= "0000";
			bv_addu(operand1, operand2, inputResult, overflow);
				if overflow then
					error <= "0001";
				end if;
				result <= inputResult;

			--Unsigned Subtract
			when "0001" => error <= "0000";
			bv_subu(operand1, operand2, inputResult, overflow);
				if overflow then
					error <= "0010";
				end if;
				result <= inputResult;

			--Add Two's Complement
			when "0010" => error <= "0000";
			bv_add(operand1, operand2, inputResult, overflow);
				--Check For Overflow Error
				if overflow then
					--Determine Underflow or Overflow
					if (operand1(31) = '1') and (operand2(31) = '1') then
						if inputResult(31) = '0' then
							error <= "0010";
						end if;
					elsif (operand1(31) = '0') and (operand2(31) = '0') then
						if inputResult(31) = '1' then
							error <= "0001";
						end if;
					end if;
				end if;
				result <= inputResult;

			-- Substract Two's Complement
			when "0011" => error <= "0000";
			bv_sub(operand1, operand2, inputResult, overflow);
				--Check For Overflow Error
				if overflow then
					--Determine Underflow or Overflow
					if (operand1(31) = '1') and (operand2(31) = '0') then
						if inputResult(31) = '0' then
							error <= "0010";
						end if;
					elsif (operand1(31) = '0') and (operand2(31) = '1') then
						if inputResult(31) = '1' then
							error <= "0001";
						end if;
					end if;
				end if;
				result <= inputResult;

			-- Multiply Two's Complement
			when "0100" => error <= "0000";
			bv_mult(operand1, operand2, inputResult, overflow);
				--Check For Overflow Error
				if overflow then
					--Determine Underflow or Overflow
					if (operand1(31) = '1') and (operand2(31) = '0') then
						error <= "0010";
					elsif (operand1(31) = '0') and (operand2(31) = '1') then
						error <= "0010";
					end if;
				end if;
				result <= inputResult;

			-- Divide Two's Complement
			when "0101" => error <= "0000";
			bv_div(operand1, operand2, inputResult, zero, overflow);
				--Check for Overflow
				if overflow then
					error <= "0010";
				elsif zero then
					error <= "0011";
				end if;
				result <= inputResult;

			--Bitwise AND
			when "0111" => error <= "0000";
			for i in 31 downto 0 loop
				inputResult(i) := operand1(i) and operand2(i);
			end loop;
			result <= inputResult;

			--Bitwise OR
			when "1001" => error <= "0000";
			for i in 31 downto 0 loop
				inputResult(i) := operand1(i) or operand2(i);
			end loop;
			result <= inputResult;

			--Bitwise NOT
			when "1011" => error <= "0000";
			for i in 31 downto 0 loop
				inputResult(i) := NOT operand1(i);
			end loop;
			result <= inputResult;

			--Operand1 To Output
			when "1100" => error <= "0000";
			result <= operand1;

			--Operand2 To Output
			when "1101" => error <= "0000";
			result <= operand2;

			--Output All Zeros
			when "1110" => error <= "0000";
			result <= x"00000000";

			--Output All Ones
			when "1111" => error <= "0000";
			result <= x"11111111";
			
			--All Other Results
			when others=> result <= x"00000000";
			
		end case;
	end process;
end architecture;
