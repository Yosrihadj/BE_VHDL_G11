library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BE_COMPAS is
  Port ( clk_50M : in STD_LOGIC;
         raz_n : in STD_LOGIC;
         in_pwm_compas : in STD_LOGIC;
         --start_stop : in STD_LOGIC;
         --data_valid : out STD_LOGIC;
         data_compas : out STD_LOGIC_VECTOR(8 downto 0)
  );
end BE_COMPAS;

architecture Behavioral of BE_COMPAS is
  signal pulse_width_counter : INTEGER := 0;
  --signal data_valid_internal : STD_LOGIC := '0';
  signal data_compas_internal : STD_LOGIC_VECTOR(8 downto 0) := (others => '0');
	signal count : INTEGER :=0;
begin
  process(clk_50M, raz_n)
  begin
    if raz_n = '0' then
      pulse_width_counter <= 0;
     -- data_valid_internal <= '0';
      data_compas_internal <= (others => '0');
    elsif rising_edge(clk_50M) then
      --if start_stop = '1' then
        if in_pwm_compas = '1' then
           
          pulse_width_counter <= pulse_width_counter + 1;
          data_compas <= data_compas_internal;
        elsif in_pwm_compas = '0' then  
          data_compas_internal <= std_logic_vector(to_unsigned((pulse_width_counter), 9)); 
          --data_valid_internal <= '1';
          pulse_width_counter <= 0;
         
        
        end if;
        
    end if;
        
  end process;
	
 --data_valid <= data_valid_internal;
 data_compas <= data_compas_internal;
	
end Behavioral;