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
public class Ex04_Menu {
    public static Scanner sc = new Scanner(System.in);
    public static void main(String[] args) {
        
        boolean sortir = false;
        do{
        System.out.print("* * * * * * M E N U * * * * * *\n" +
                           "===============================\n" +
                           "A - [Ex. 23] Taula divisió entera\n" +
                           "B - [Ex. 26] Fibonacci\n" +
                           "C - [Ex. 01] Compta vocals\n" +
                           "X - SORTIR\n" +
                           "Tria una opció: ");
        char opcio = ' ';
        boolean operacioCorrecta = false;
        while(!operacioCorrecta){
            String entrada = sc.nextLine().toUpperCase();
            if(entrada.length()== 1 &&
                    entrada.charAt(0)=='A'|| entrada.charAt(0)=='B'||
                    entrada.charAt(0)=='C'|| entrada.charAt(0)=='X'){
                opcio = entrada.charAt(0);
                operacioCorrecta = true;
            }else{
                System.out.print("Operacio incorrecta \n"+
                "Tria una opció: ");
            }
            
        }
        switch (opcio){
            case 'A':
                taulaDivisioEntera();
                break;
            case 'B':
                fibonacci();
                break;
            case 'C':
                comptaVocals();
                break;
            case 'X':
                sortir=true;
                break;           
        }
            System.out.println("");
            System.out.println("");
        }while(!sortir);
        
    }
    
    public static void taulaDivisioEntera () {
   
        boolean sortir = false;
        while(!sortir)
        {
            System.out.print("Introdueix un nombre natural: ");
            if (sc.hasNextInt())
            {
                int n = sc.nextInt();
                if (n > 0)
                {                
                    for (int i = 1; i <= 10; ++i)
                    {
                        System.out.println(n + " / " + i + ": quocient = " + 
                                (n / i) + " i residu = " + (n % i));
                    }
                    sortir = true;
                }
            }
            sc.nextLine();
        }   
    }
    
    public static void fibonacci() {
            //Scanner sc = new Scanner(System.in);
        int n,f1,f2,i;
        do{
            System.out.print("Introdueixi un nombre natural: ");
            n = sc.nextInt();
        }
        while(n<=1);  
            System.out.println("Els " + n + " primers termes de la successió de Fibonacci són:");                 
            f1=1;
            f2=1;
            System.out.print(f1 + " ");
        for(i=2;i<=n;i++){
            System.out.print(f2 + " ");
            f2 = f1 + f2;
            f1 = f2 - f1;
        }
        System.out.println();
        sc.nextLine();
    }
    
    public static void comptaVocals (){
        //Scanner sc = new Scanner(System.in);
        System.out.print("Esctriu una frase: ");  
        String frase = sc.nextLine();
        int totalVocals=0;
        for (int i = 0; i < frase.length(); i++) {
            char caracter = frase.toLowerCase().charAt(i);
            if (caracter== 'a'|| caracter== 'e'|| caracter== 'i'|| caracter== 'o'|| caracter== 'u'||
                caracter== 'á'|| caracter== 'é'|| caracter== 'í'|| caracter== 'ó'|| caracter== 'ú'|| 
                caracter== 'à'|| caracter== 'è'|| caracter== 'ì'|| caracter== 'ò'|| caracter== 'ù'||
                caracter== 'ä'|| caracter== 'ë'|| caracter== 'ï'|| caracter== 'ö'|| caracter== 'ü'){
            totalVocals++;    
            }      
        }
        System.out.println("La frase te "+totalVocals+" vocals");
    }
}
