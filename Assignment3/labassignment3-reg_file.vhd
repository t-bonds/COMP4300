--Author: 	Tanner Bonds
--Due Date:	3/20/2020
--Assignment Three

library work;
use work.bv_arithmetic.all;
use work.dlx_types.all;

entity reg_file is
	generic(propagation: time := 15 ns);
	port(data_in : in dlx_word; 
		readnotwrite, clock: in bit;
		data_out: out dlx_word; 
		reg_number: in register_index);
end entity reg_file;

architecture data of reg_file is
type reg_type is array (0 to 31) of dlx_word;
begin 
	process(data_in, readnotwrite, clock, reg_number)
	variable registers : reg_type;
	begin
		if clock = '1' then
			if readnotwrite = '1' then
				data_out <= registers(bv_to_integer(reg_number)) after propagation;
			else registers(bv_to_integer(reg_number)) := data_in;
			end if;
		end if;
	end process;	
end architecture; 

		
	