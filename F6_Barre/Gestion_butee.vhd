library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Gestion_butee is
    port 
    (
        pwm_on, sens, enable	:	in  std_logic;
        angle_barre				:	in  std_logic_vector(11 downto 0);			 
		  butee_g, butee_d   	:	in  std_logic_vector(11 downto 0);
        out_pwm, out_sens, out_fin_g, out_fin_d		: 	out std_logic
    );
end entity Gestion_butee;

architecture Arch_butee of Gestion_butee is
    signal fin_course_d, fin_course_g :   std_logic;   

begin

    controle_butee: process(sens, butee_g, butee_d, angle_barre, pwm_on)
    begin
        if angle_barre >= butee_d then
            fin_course_d <= '1';
        else 
            fin_course_d <= '0';
        end if;
        if  angle_barre <= butee_g then
            fin_course_g <= '1';
        else
            fin_course_g <= '0';
        end if;
    end process controle_butee;
        out_pwm     <= enable and pwm_on and (((not fin_course_d) and sens) or ((not fin_course_g) and (not sens))) ; 
        out_sens    <= sens;
		  out_fin_g	  <= fin_course_g;
		  out_fin_d	  <= fin_course_d;
		  
end architecture Arch_butee;