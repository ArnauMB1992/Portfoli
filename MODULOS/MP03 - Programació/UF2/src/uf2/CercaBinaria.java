/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uf2;

/**
 *
 * @author ArnauMB
 */
public class CercaBinaria {
    
    public static void main(String[] args) {
        
        int[] nombres = {8, 9, 19, 24, 25, 27, 31, 34, 37};
        
        int valor = 27;
        int resultat = cercaBinaria(nombres,valor);
        if (resultat != -1)
            System.out.println("El " + valor + " es troba a la posicio " + resultat);
        else
            System.out.println("El " + valor+ " no s'ha trobat");
    }
    
    static int cercaBinaria(int[] nombres, int valor) {
        
        int resultat = -1;
        int izq = 0;
        int der = nombres.length-1;
        int pas = 1;
        while (izq <= der && resultat == -1) {
            int med = (izq + der)/2;
            System.out.println("Pas " + pas + ": esq = " + izq + 
                               ", dre = " + der + ", med = " + med);
            if (nombres[med] == valor)            
                resultat = med;
            else if (nombres[med] < valor) {
                izq = med + 1;
            }
            else
                der = med - 1;
            
            pas++;
        }
        return resultat;
    }
}
