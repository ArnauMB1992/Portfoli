/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package UF2A2;


import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;

/**
 *
 * @author ArnauMB
 */
public class Ex03_Practica02 {
    
    public static void main(String[] args) {
        Scanner sc= new Scanner(System.in);
        ArrayList<String> paisos = new ArrayList<String>();
        int n;
        System.out.print("Cuantos paises quieres ordenar ?");
        n=sc.nextInt();
        sc.nextLine();
        
        for (int i=0; i<n; i++){
            System.out.print((i+1)+". Diga un pais: ");
            paisos.add(sc.nextLine());
        }
        ordenar(paisos);
        System.out.println("Països ordenats: ");
        mostrarElements(paisos);
        
    }
    
    
    static void mostrarElements(ArrayList<String> p) {
        
        for (String pais : p) {
            System.out.println(pais);
        }
            
    }
    
    static void ordenar(ArrayList<String> p) {
        Collections.sort(p);
    }
}
