/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package aceptaunreto;

import java.util.Scanner;

/**
 *
 * @author Arnau Muñoz
 */
public class ej116 {
        public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Ingresa el número de veces que quieres que se repita. ");
        int n = scanner.nextInt();
        for (int i=1;i<=n;i++)
        {
            System.out.println("Hola mundo.");
        }
    }
}

