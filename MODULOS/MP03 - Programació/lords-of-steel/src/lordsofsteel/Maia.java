/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package lordsofsteel;

/**
 *
 * @author ArnauMB
 */
public class Maia extends Personatge{
    
    public Maia (String NOM, int FOR, int CON, int VEL, int INT, int SOR, Armes arma){
        super(NOM, FOR, CON, VEL, INT, SOR, arma);
    }
    
            @Override
     protected void calculaEstadistiquesSecundaries(){
         super.calculaEstadistiquesSecundaries();
         PA = INT+SOR+WVEL+VEL;
     }
}
