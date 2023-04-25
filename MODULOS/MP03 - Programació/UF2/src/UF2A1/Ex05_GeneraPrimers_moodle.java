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
public class Ex05_GeneraPrimers_moodle {
    public static Scanner sc = new Scanner(System.in);
    static int numero=sc.nextInt();
    public static void main(String[] args) {
        //System.out.println("cuantos numeros primos quieres?");
        
        int primers [] = new int [numero];
        int n = 2;
        int index = 0;
        while(index<numero){
            if (esNombrePrimer(n)){
                primers[index]=n; 
                index++; 
            }
        n++;
        }
        mostrarVector(primers);
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
    static void mostrarVector(int[] primers){        
        for(int i=0;i<numero;i++){
            if(i==numero-1){
                System.out.println(primers[numero-1]+".");
            }
            else{
                System.out.print(primers[i]+", ");
                if ((i+1)%10==0)
                    System.out.println("");
            }
        }
    }
}
    