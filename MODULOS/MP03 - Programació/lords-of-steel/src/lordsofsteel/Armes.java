/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package lordsofsteel;

/**
 *
 * @author ArnauMB
 */
public class Armes {
    
    protected String tipus;
    protected int WPOW;
    protected int WVEL; 


    public Armes(String tipus){
        this.tipus = tipus;
        switch (tipus){
            case "Daga":
                this.WPOW = 5;
                this.WVEL = 15;
            break;
            case "Espasa":
                this.WPOW = 10;
                this.WVEL = 10;
            break;
            case "Martell":
                this.WPOW = 15;
                this.WVEL = 5;
            break;
        }
        
    }   
    
    public void setTipus(String tipus) {
        this.tipus = tipus;
    }

    public void setWPOW(int WPOW) {
        this.WPOW = WPOW;
    }

    public void setWVEL(int WVEL) {
        this.WVEL = WVEL;
    }

    public String getTipus() {
        return tipus;
    }

    public int getWPOW() {
        return WPOW;
    }

    public int getWVEL() {
        return WVEL;
    }
    
}
