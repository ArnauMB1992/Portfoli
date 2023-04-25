/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package UF2A2;

import java.util.Collections;
import java.util.Scanner;

/**
 *
 * @author ArnauMB
 */
public class ordenaPaisesSort {
    
public static void main(String[] args) {
        
        Scanner sc= new Scanner(System.in);
        int n, aux;
        String arreglo[];
        System.out.print("Cuantos paises quieres ordenar ?");
        n=sc.nextInt();
        arreglo = new String[n+1];
        System.out.println("Llenar el arrelgo");
        for (int i=0; i<n; i++){
            System.out.print((i+1)+". Digite un numero: ");
            arreglo[i]=sc.nextLine();
        }
        String[] ordenado = stringArraySort(arreglo);
        System.out.println("Mostando arreglo ordenado crecientemente");
        for(int i=0;i<n;i++){
            System.out.print(ordenado[i]+" ");
        }

    }

    private static String[] stringArraySort(String[] arreglo) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}

