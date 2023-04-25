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
public class Ex08_PedraPaperTisoresLlangardaixSpock {
    public static Scanner sc = new Scanner (System.in);
    public static void main(String[] args) {
        
        int [][] resultatJugada= {{0,-1,1,1,-1},
                                  {1,0,-1,-1,1},
                                  {-1,1,0,1,-1},
                                  {-1,1,-1,0,1},
                                  {1,-1,1,-1,0}};
        String[] jugada = {"pedra","paper","tisores","llangardaix","Spock"};
        boolean finalPartida = false;
        do{    
            //mostrar ronda y marcador
            int ronda = 1;
            int marcadorHuma = 0, marcadorPc = 0;
            while(marcadorPc < 3 && marcadorHuma < 3 ){
                System.out.println("Ronda: "+ronda+" [Jugador: "+marcadorHuma+" - Ordinador: "+marcadorPc+"]");
                //pide jugada humano
                System.out.print("pedra(0), paper(1), tisores(2), llangardaix(3), spock(4): ");
                int jugadaHuma = jugadaHuma();
                //pide jugada pc
                int jugadaPc = jugadaOrdinador();

                System.out.print("El jugador ha tret "+jugada[jugadaHuma]+". ");
                System.out.print("L'ordinador ha tret "+jugada[jugadaPc]+". ");

                //comprueba quien gana
                int resultat = resultatJugada[jugadaHuma][jugadaPc] ;
                switch (resultat) {
                    case -1:
                        System.out.println("Guanya l'ordinador!!");
                        marcadorPc++;
                        break;
                    case 1:
                        System.out.println("Guanya el jugador!!");
                        marcadorHuma++;
                        break;
                    default:
                        System.out.println("Empat.");
                        break;
                }
                System.out.println("");
                //comprobar si alguien a ganado 3 rondas 
                if(marcadorPc == 3||marcadorHuma == 3){
                    System.out.println("La partida ha acabat en "+ronda+" rondes.\n" +
                                       "El marcador ha estat:\n" +
                                       "Jugador: "+marcadorHuma+" - Ordinador: "+marcadorPc);
                    System.out.print("Vols fer una nova partida? [S/N]: ");
                    sc.nextLine();
                    char nuevaPartida = sc.nextLine().toUpperCase().charAt(0);
                    if(nuevaPartida == 'N'){
                         finalPartida = true;
                    }else{
                        System.out.println("\n");
                    }
                } 
                ronda++;
            }
        }while(!finalPartida);
    }
    public static int jugadaHuma(){
        boolean entradaCorrecta = false;
        int jugada= 0;
        
        do{
            if (sc.hasNextInt()){
                jugada=sc.nextInt();
                if(jugada>=0 && jugada<=4){
                    entradaCorrecta= true;
                }
            }
            if(!entradaCorrecta){
                sc.nextLine();
                System.out.print("pedra(0), paper(1), tisores(2), llangardaix(3), spock(4): ");
            }
        }while(!entradaCorrecta);
        
        return jugada;
        
    }
    public static int jugadaOrdinador(){
//        int min = 0, max = 4;
//        int jugada = (int)(Math.random()*(max-min+1))+min;
        return (int)(Math.random()*5);
    }
}
