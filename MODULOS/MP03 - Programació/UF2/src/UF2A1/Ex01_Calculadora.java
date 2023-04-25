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
public class Ex01_Calculadora {
    
    public static void main(String[] args) {
        
        Scanner sc = new Scanner(System.in);
        
        System.out.print("Introdueix el primer valor: ");
        int valor1 = sc.nextInt();
        
        System.out.print("Introdueix el segon valor : ");
        int valor2 = sc.nextInt();
        
        sc.nextLine();
        
        char operacio = ' ';

        while (true) {
            System.out.print("Introdueix l'operació (+,-,x,/): ");
            String entrada = sc.nextLine();
            if (entrada.length() == 1 && 
                (entrada.charAt(0) == '+' || entrada.charAt(0) == '-' ||
                entrada.charAt(0) == 'x' || entrada.charAt(0) == '/')) {
                operacio = entrada.charAt(0);
                break;
            } else {
                System.out.println("Operació incorrecta!");
            }
        }
        
        
        // Calcular el resultat segons els valors i l'operació.
        int resultat = calcularResultat(valor1,valor2,operacio);

        System.out.println("El resultat és: " + resultat);
        
    }
    
    
    public static int calcularResultat(int primerValor,int segonValor,char op) {
        
        int resultat = 0;
        switch (op) {
            case '+':
                resultat = primerValor + segonValor;
                break;
            case '-':
                resultat = primerValor - segonValor;
                break;
            case 'x':
                resultat = primerValor * segonValor;
                break;
            case '/':
                // Fer fóra del mètode si no volem que ens mostri 
                // resultat = 0
                try {
                    resultat = primerValor / segonValor;
                } catch (java.lang.ArithmeticException e) {
                    System.out.println("No es pot dividir per 0!");
                }
                break;                            
        }
        
        return resultat;
    }
}

