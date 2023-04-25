/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package UF2A2;

import java.util.Scanner;

/**
 *
 * @author ArnauMB
 */
public class Ex02_TaulesMultiplicar {
        
    public static void main(String[] args) {
        
        
        Scanner sc = new Scanner(System.in);
        mostrarBlocPantalla(5,6);


                
    }
    
    
    static String muntarLiniaTaulaMultiplicar(int taula,int n) {
        
        String resultat = taula + " x " + n + " = " + taula*n;                        
        return resultat;
    }
    
    
    static String muntarLiniaPantalla(int taulaInicial, int taulaFinal, int n) {

        String resultat = "";
        for (int i = taulaInicial; i <= taulaFinal ; i++) {
            String linia  = muntarLiniaTaulaMultiplicar(i,n)  + "\t";
            resultat = resultat + linia;
        }
        
        return resultat;
    }

    static void mostrarBlocPantalla(int taulaInicial, int taulaFinal) {

        for (int j = 1; j <= 10; ++j) {
            String linia = muntarLiniaPantalla(taulaInicial,taulaFinal,j);
            System.out.println(linia);
        }        
    }
}


