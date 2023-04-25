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
public class Ex01_calculadora_moodle {
        public static void main(String[] args) {
        Scanner sc= new Scanner(System.in);
        
        do{
            System.out.print("Introduce el primer valor: ");
            char nuevaPartida = sc.nextLine().toUpperCase().charAt(0);
            if(nuevaPartida == 'S'){
                break;
            }
                int valor1 =  Character.getNumericValue(nuevaPartida);
                
            System.out.print("Introduce el segundo valor: ");
            int valor2 =sc.nextInt();

            sc.nextLine();

            char operacio = ' ';
            boolean operacioCorrecta = false;
            int resultat=0;

            while(!operacioCorrecta){
                System.out.print("Introduce la operacion a relaizar: (+, -, x, /) ");
                String entrada = sc.nextLine();
                if(entrada.length()== 1 &&
                        entrada.charAt(0)=='+'|| entrada.charAt(0)=='-'||
                        entrada.charAt(0)=='x'|| entrada.charAt(0)=='/'){
                    operacio = entrada.charAt(0);
                    operacioCorrecta = true;
                }else{
                    System.out.println("Operacio incorrecta");
                }
            }
            
            boolean divCero = false;
            switch (operacio) {
                case '+':
                    resultat = sumar(valor1,valor2);
                    break;
                case '-':
                    resultat = restar(valor1,valor2);
                    break;
                case 'x':
                    resultat =  multiplicar(valor1,valor2);
                    break;
                case '/':
                    try {
                        resultat = dividir(valor1,valor2);
                    } catch (java.lang.ArithmeticException e) {
                        divCero=true;
                    }
                    break;                            
            }
            if (!divCero){
                System.out.println(valor1+" "+operacio+" "+valor2+" = "+resultat);
            }
            else{
                System.out.println("No es pot dividir per 0.");
            }    
        }while(true);
    }
        public static int sumar(int a, int b){
            int resultat = a + b;
            return resultat;  
        }
        public static int restar(int a, int b){
            int resultat = a - b;
            return resultat; 
        }
        public static int multiplicar(int a, int b){
            int resultat = a * b;
            return resultat; 
        }
        public static int dividir(int a, int b){
            int resultat = a / b;
            return resultat; 
        }
}
