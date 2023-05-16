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
public class ej117 {
    public static void main(String[] args) {
	Scanner sc = new Scanner(System.in);
	int casos;
	casos = sc.nextInt();
	String nombre;
	for (int i = 1; i <= casos; i++) {
            sc.next();
            nombre = sc.next();
            System.out.println("Hola, " + nombre + ".");
	}
	sc.close();
    }
}