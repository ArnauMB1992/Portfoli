/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package UF2A1;

import java.util.Scanner;

/**
 *
 * @author ArnauMB
 */
public class Ex05_GeneraPrimers {
    public static Scanner sc = new Scanner(System.in);
    public static void main(String[] args) {
        int primers [] = new int [100];
        int n = 2;
        int index = 0;
        while(index<100){
            if (esNombrePrimer(n)){
                primers[index]=n; 
                index++; 
            }
        n++;
        }
        for(int i=0;i<100;i++){
            System.out.println(i+". "+primers[i]);
        }
    }
    
    static boolean esNombrePrimer(int nombre){       

        boolean esPrimer = true;
        for (int i= 2; i<nombre&& esPrimer == true; i++)
        {
            if (nombre% i == 0)
             esPrimer = false;
        }
       
        return esPrimer;
    }
}
