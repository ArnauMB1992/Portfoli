/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uf2;

/**
 *
 * @author ArnauMB
 */
public class OrdenaCanalla {
 
    public static void main(String[] args) {
        
        String[] canalla = {"Marc,130","Anna,125","Oriol,129","Júlia,126","Gemma,95"};
        
        System.out.println("Canalla abans d'ordenar per alçada:");
        mostraElements(canalla);
        
        ordenaSeleccio(canalla);

        System.out.println("\nCanalla després d'ordenar per alçada:");
        mostraElements(canalla);
    }
    
    
    
        static void ordenaSeleccio(String[] noms) {

        for(int i = 0; i < noms.length-1 ; ++i)
        {
            for (int j = i+1; j < noms.length;++j)
            {
                int nom1 = Integer.parseInt(noms[i].split(",")[1].trim());
                int nom2 = Integer.parseInt(noms[j].split(",")[1].trim());
                if(nom1>nom2)
                {   
                    // Intercanviem posicions
                    String aux = noms[i];
                    noms[i] = noms[j];
                    noms[j] = aux;                    
                }
            }
        }
        
    }
    

    static void mostraElements(String[] canalla) {
        
        for(int i = 0; i < canalla.length ; ++i)
            System.out.println(canalla[i].split(",")[0].trim()+" (alçada: "+canalla[i].split(",")[1].trim()+")");
        
    }
    
    
}