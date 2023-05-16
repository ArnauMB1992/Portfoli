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
public class ej155 {
        public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        long m=scanner.nextInt();
        long n=scanner.nextInt();
        while(n>=0 && m>=0){
            System.out.println((m+n)*2);
            n = scanner.nextInt();
            m = scanner.nextInt();
        }
    }       
}
