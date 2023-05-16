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
public class ej403 {
    public static void main(String[] args) {
	Scanner sc = new Scanner(System.in);
	int vueltas = sc.nextInt();
	for (int i = 0; i < vueltas; i++) {
            double largo = sc.nextDouble();
            double ancho = sc.nextDouble();
            if (45 * 90 <= largo / ancho && 120 * 90 >= largo / ancho) {
                System.out.println("SI");
            } 
            else {
		System.out.println("NO");
            }
	}
    }
}

