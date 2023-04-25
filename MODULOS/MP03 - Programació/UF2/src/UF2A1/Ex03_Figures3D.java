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
public class Ex03_Figures3D {
    public static void main(String[] args) {
        Scanner sc= new Scanner(System.in);
        char opcio;
        do{
//            System.out.println("**SELECCIONA FIGURA 2D **");
//            System.out.println("1.Cilindre");
//            System.out.println("2.Hexaedre regular");
//            System.out.println("3.Tetraedre");
//            System.out.println("4.Esfera");
//            System.out.println("\n Tria una opcio[1-4]:");
            
            opcio = sc.nextLine().toUpperCase().charAt(0);
                if(opcio == 'S'){
                    break;
                }
            
        
        double volum = 0.0, superficie = 0.0;
        switch(opcio){
            case 'H':
                //System.out.println("Costat: ");
                System.out.println("==Hexaedre==");
                double costat=sc.nextDouble();
                sc.nextLine();
                volum = calculaVolumenHexaedre(costat);
                superficie = calculaSuperficieHexaedre(costat);
                System.out.printf("Superfície: %.2f \n", superficie);
                System.out.printf("Volum: %.2f \n", volum);
                break;
            case 'E':
                double radiEsfera=sc.nextDouble();
                sc.nextLine();
                System.out.println("==Esfera==");
                volum = calculaVolumenEsfera(radiEsfera);
                superficie = calculaSuperficieEsfera(radiEsfera);
                System.out.printf("Superfície: %.2f \n", superficie);
                System.out.printf("Volum: %.2f \n", volum);    
                break;
            case 'T':
                double aresta=sc.nextDouble();
                sc.nextLine();
                System.out.println("==Tetraedre==");
                volum = calculaVolumenTetraedre(aresta);
                superficie = calculaSuperficieTetraedre(aresta);
                System.out.printf("Superfície: %.2f \n", superficie);
                System.out.printf("Volum: %.2f \n", volum);   
                break;
            case 'C':
                //System.out.println("Radi: ");
                double radiCilindre=sc.nextDouble();
                sc.nextLine();
                double alturaCilindre=sc.nextDouble();
                sc.nextLine();
                System.out.println("==Cilindre==");
                volum = calculaVolumenCilindro(radiCilindre,alturaCilindre);
                superficie = calculaSuperficieCilindro(radiCilindre,alturaCilindre);
                System.out.printf("Superfície: %.2f \n", superficie);
                System.out.printf("Volum: %.2f \n", volum);
                break;
        }

    }while(true);
        }
    public static double calculaVolumenHexaedre(double costat){
        double resultat = costat*costat*costat;
        return resultat;
    }
    public static double calculaSuperficieHexaedre(double costat){
        double resultat = 6*(costat*costat);
        return resultat;
    }
    public static double calculaVolumenEsfera(double radi ){
        double resultat = 4*Math.PI*(radi*radi*radi)/3;
        return resultat;
    }
    public static double calculaSuperficieEsfera(double radi ){
        double resultat = 4*Math.PI*(radi*radi);
        return resultat;
    }
    public static double calculaVolumenTetraedre(double aresta ){
        double resultat = (Math.sqrt(2)/12)*(aresta*aresta*aresta);
        return resultat;
    }
    public static double calculaSuperficieTetraedre(double aresta ){
        double resultat = (aresta*aresta)*Math.sqrt(3);
        return resultat;
    }
    public static double calculaVolumenCilindro(double radi, double alturaCilindre){
        double resultat = Math.PI*(radi*radi)*alturaCilindre;
        return resultat;
    }
    public static double calculaSuperficieCilindro(double radi, double alturaCilindre){
        double resultat = 2*Math.PI*radi*(radi+alturaCilindre);
        return resultat;
    }
}
