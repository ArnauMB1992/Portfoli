/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package uf2;
import java.io.PrintStream;
import java.io.UnsupportedEncodingException;
import java.util.Scanner;

public class Ahorcado3 {
   
    public static int oportunidades = 6;

    public static void main(String[] args) throws UnsupportedEncodingException {
        String[] palabras = {
            "Argentina",
            "Belice",
            "Bolivia",
            "Brasil",
            "Canada",
            "Colombia",
            "Cuba",
            "Chile",
            "Ecuador",
            "El Salvador",
            "Espa\u00F1a",
            "Estados Unidos",
            "Guatemala",
            "Haiti",
            "Honduras",
            "Mexico",
            "Panama",
            "Paraguay",
            "Peru",
            "Puerto Rico",
            "Republica Dominicana",
            "Uruguay",
            "Venezuela"
        };
        String linea, palabra = palabras[(int) (Math.random()*palabras.length)];
        int i, n = palabra.length(), turnos = 0, aciertos = 0;
        char letra, caracter, cabeza = ' ', cuerpo = ' ', manoIzquierda = ' ',
             manoDerecha = ' ', pieIzquierdo = ' ', pieDerecho = ' ';
        char[] casillas = new char[n];
        boolean encontrado;
        for(i=0; i<n; i++)
            casillas[i] = '_';
        Scanner teclado;
        PrintStream out;
        if (System.getProperties().get("os.name").equals("Linux")
           || System.console()==null) {
            teclado = new Scanner(System.in);
            out = new PrintStream(System.out);
        } else {
            teclado = new Scanner(System.in, "CP850");
            out = new PrintStream(System.out, true, "CP850");
        }
        do {
            out.println("\nOportunidades restantes: " + (oportunidades-turnos));
            for(i=0; i<n; i++)
                out.print(" " + casillas[i]);
            out.print("\nEscriba una letra: ");
            do {
                linea = teclado.nextLine();
            } while(linea.isEmpty());
            letra = linea.charAt(0);
            encontrado = false;
            for(i=0; i<n; i++) {
                caracter = palabra.charAt(i);
                if(Character.toUpperCase(letra)==Character.toUpperCase(caracter)) {
                    encontrado = true;
                    if(casillas[i]=='_') {
                        casillas[i] = caracter;
                        aciertos++;
                    }
                }
            }
            if(!encontrado) {
                turnos++;
                out.println("Letra no encontrada.");
                switch(turnos) {
                case 1: cabeza        = 'O'; break;
                case 2: cuerpo        = '|'; break;
                case 3: manoDerecha   = '/' ; break;
                case 4: manoIzquierda = '\\'; break;
                case 5: pieDerecho    = '/' ; break;
                case 6: pieIzquierdo  = '\\'; break;
                }
            }
            out.println("     " + cabeza + " ");
            out.println("    " + manoDerecha + "" + cuerpo + "" + manoIzquierda);
            out.println("    " + pieDerecho + " " + pieIzquierdo + "\n");
        } while(turnos<oportunidades&&aciertos<n);
        if(aciertos==n)
            out.println("Felicidades, has ganado");
        else
            out.println("Has perdido.");
        out.println("La palabra secreta es: " + palabra + "\n\n");
    }

}
