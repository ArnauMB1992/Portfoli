/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package lordsofsteel;

import java.util.ArrayList;
import java.util.Scanner;
import lordsofsteel.*;
/**
 *
 * @author ArnauMB
 */
public class LordsofSteel {
    static Scanner sc = new Scanner(System.in);
    public static void main(String[] args) {
        Nan n1 = new Nan("Tirion",8,6, 13,16,16,new Armes("Daga"));        
        Huma h1 = new Huma("Luis",13,16,6,10,6,new Armes("Espasa"));
        Mitja mi1 = new Mitja("Frodo",9,7,7,15,16,new Armes("Martell"));
        Maia ma1 = new Maia("Nil",7,9, 12,15,17,new Armes("Daga"));

        ArrayList<Personatge> personatges = new ArrayList<Personatge>();
        personatges.add(n1);
        personatges.add(h1);
        personatges.add(mi1);
        personatges.add(ma1);
        int opcio;
        do{
        /* Menú principal */
        System.out.println("");
        System.out.println("** MENÚ PRINCIPAL **");
        System.out.println("1.- Afegir personatge");
        System.out.println("2.- Esborrar personatge");
        System.out.println("3.- Editar personatge");
        System.out.println("4.- Iniciar combat");
        System.out.println("5.- Sortir");
        System.out.println("**__________________**");
        System.out.print("Tria opció [1-5]: ");
        
         opcio = leerEnteroValido();
        
        // Només hem d'arribar aquí si estem segurs
        // que l'opció triada és un enter entre 1-5
        //opcio = Integer.parseInt(entrada);
              
        switch (opcio) {
            case 1:
                agregaPersonatge(personatges);
                break;
            case 2:
                borrarPersonatge(personatges);
                break;
            case 3:
                editaPersonatge(personatges);
                break;
            case 4:
                iniciarCombat(personatges);
                break;
            case 5:
                System.out.println("¡Ha triat sortit!");
                break;
            default:
                System.out.println("Opcio invalida.");
        }
        }while(opcio !=5);    
    }
    
    private static void agregaPersonatge(ArrayList<Personatge> personatges){
        int categoria;
        do{
        System.out.println("Introdueix la categoria del personatge: ");
        System.out.println("1: Nan");
        System.out.println("2: Humá ");
        System.out.println("3: Mitjà");
        System.out.println("4: Maia");
        categoria =leerEnteroValido();
        }while(categoria>5||categoria<0);
        int devocion;
        do{
        System.out.println("Introdueix la devoció del personatge: ");
        System.out.println("1: Ordre o 2: Caos");
        devocion = leerEnteroValido();
        }while(devocion>3||devocion<0);
        System.out.println("Introdueix el nom del personatge: ");
        String nom=sc.nextLine();
        int fuerza, constitucion, velocidad, inteligencia, suerte, totalPunts;
        do{
            System.out.println("Reparteix 60 punts entre les estadístiques primàries:");
            System.out.println("Força: ");
            fuerza = leerEnteroValido();
            System.out.println("Constitució: ");
            constitucion = leerEnteroValido();
            System.out.println("Velocitat: ");
            velocidad = leerEnteroValido();
            System.out.println("Intel·ligència: ");
            inteligencia = leerEnteroValido();
            System.out.println("Sort: ");
            suerte = leerEnteroValido();
            
            totalPunts = fuerza+constitucion+velocidad+inteligencia+suerte;
            if (totalPunts!=60){
                System.out.println("Assegura't de repartir un total de 60 punts entre les estadístiques primàries: força, destresa, constitució i agilitat.");                
            }
        }while(totalPunts!=60);
        int arma;
        String nomArma=" ";
        do{
            System.out.println("Introdueix una arma de l'arma: ");
            System.out.println("1: Daga");
            System.out.println("2: Espasa");
            System.out.println("3: Martell");
             arma = leerEnteroValido();
            
            switch (arma){
            case 1:
                nomArma="Daga";
            break;
            case 2:
                nomArma="Espasa";
            break;
            case 3:
                nomArma="Martell";
            break;
        }
        }while(arma>4||arma<0);
        switch (categoria) {
            case 1:
                {
                    if(devocion==1){
                        NanOrdre personatge = new NanOrdre(nom,fuerza,constitucion, velocidad,inteligencia ,suerte,new Armes(nomArma));
                        personatges.add(personatge);
                    }else{
                        NanCaos personatge = new NanCaos(nom,fuerza,constitucion, velocidad,inteligencia ,suerte,new Armes(nomArma));
                        personatges.add(personatge);
                    }
                    break;
                }
            case 2:
                {   
                    if(devocion==1){
                        HumaOrdre personatge = new HumaOrdre(nom,fuerza,constitucion, velocidad,inteligencia ,suerte,new Armes(nomArma));
                    personatges.add(personatge);
                    }else{
                        HumaCaos personatge = new HumaCaos(nom,fuerza,constitucion, velocidad,inteligencia ,suerte,new Armes(nomArma));
                        personatges.add(personatge);
                    }
                    break;
                }
            case 3:
                {
                    if(devocion==1){
                        MitjaOrdre personatge = new MitjaOrdre(nom,fuerza,constitucion, velocidad,inteligencia ,suerte,new Armes(nomArma));
                        personatges.add(personatge);
                    }else{
                        MitjaCaos personatge = new MitjaCaos(nom,fuerza,constitucion, velocidad,inteligencia ,suerte,new Armes(nomArma));
                        personatges.add(personatge);
                    }
                    break;
                }
            case 4:
                {   
                    if(devocion==1){
                        MaiaOrdre personatge = new MaiaOrdre(nom,fuerza,constitucion, velocidad,inteligencia ,suerte,new Armes(nomArma));
                        personatges.add(personatge);
                    }else{
                        MaiaCaos personatge = new MaiaCaos(nom,fuerza,constitucion, velocidad,inteligencia ,suerte,new Armes(nomArma));
                        personatges.add(personatge);
                    }
                    break;
                }
            default:
                break;
        }
            System.out.println("S'ha afegit el personatge amb èxit.");
    }
    
    private static void borrarPersonatge(ArrayList<Personatge> personatges){
        System.out.println("----- LLISTA DE PERSONATGES DISPONIBLES -----");
        for (int i = 0; i < personatges.size(); ++i) {
            System.out.println((i+1)+ ". "+ personatges.get(i).getNOM());            
        }
        System.out.println("-----------------------------------");
        boolean valido = false;
//        do{
            System.out.println("Si us plau, seleccioneu el número del personatge que voleu eliminar: ");
            int seleccio = leerEnteroValido() -1;

            if(seleccio>=0 && seleccio<personatges.size()){
                personatges.remove(seleccio);
                System.out.println("S'ha eliminat el personatge amb èxit.");
                valido=true;
            } else {
                System.out.println("Ho sento, el número de personatge no és vàlid. Si us plau, seleccioneu un número de personatge vàlid per continuar.");
            }
//        } while(!valido);
        System.out.println("");
    }
    
    private static void editaPersonatge(ArrayList<Personatge> personatges){
        System.out.println("----- LLISTA DE PERSONATGES DISPONIBLES -----");
        for (int i = 0; i < personatges.size(); ++i) {
            System.out.println((i+1)+ ". "+ personatges.get(i).getNOM());            
        }
        System.out.println("-----------------------------------");
        boolean valido = false;
        System.out.println("Si us plau, seleccioneu el número del personatge que voleu modificar: ");
        int seleccio = leerEnteroValido() -1;
        if(seleccio>=0 && seleccio<personatges.size()){
            Personatge personatge = personatges.get(seleccio);
            System.out.println("Estadístiques actuals del personatge:");
            System.out.println("Nom: "+personatge.getNOM()+" Força: "+personatge.getFOR()+" Constitució: "+personatge.getCON()+
                    " Velocitat: "+personatge.getVEL()+" Intel·ligència: "+personatge.getINT()+
                    " Sort: "+personatge.getSOR());
            int newFuerza, newConstitucion, newVelocidad, newInteligencia, newSuerte;
            do{
                System.out.println("Introdueix el nou valor de Força:");
                newFuerza=leerEnteroValido();
                System.out.println("Introdueix el nou valor de Constitució:");
                newConstitucion=leerEnteroValido();
                System.out.println("Introdueix el nou valor de Velocitat:");
                newVelocidad=leerEnteroValido();
                System.out.println("Introdueix el nou valor de Intel·ligència:");
                newInteligencia=leerEnteroValido();
                System.out.println("Introdueix el nou valor de Sort:");
                newSuerte=leerEnteroValido();
            int totalPunts = newFuerza+newConstitucion+newVelocidad+newInteligencia+newSuerte;
            if(totalPunts <=60){    
                valido = true;
            }else{
                System.out.println("Ho sento, però el total de punts excedeix els punts disponibles. Si us plau, torna-ho a intentar distribuint els punts de manera que la suma total no superi el límit disponible.");
            }
            }while(!valido);
            
            personatge.setFOR(newFuerza);
            personatge.setCON(newConstitucion);
            personatge.setVEL(newVelocidad);
            personatge.setINT(newInteligencia);
            personatge.setSOR(newSuerte);
            
            System.out.println("Les estadístiques del personatge s'han actualitzat amb èxit.");
            System.out.println("");
        }
    }
    
        public static void iniciarCombat(ArrayList<Personatge> personatges) {
        
        boolean[] seleccionats = new boolean[personatges.size()];
        Personatge[] lluitadors = new Personatge[2];
        //for (Personatge p : personatges)
        for (int selec = 1; selec <= 2; selec++) {
            for (int i = 0; i < personatges.size(); ++i) {
                if (!seleccionats[i]) {
                    String tipus = "";
                    if (personatges.get(i) instanceof Nan)
                        if(personatges.get(i) instanceof NanOrdre){
                            tipus = "NanOrdre";
                        }else if(personatges.get(i) instanceof NanCaos){
                            tipus = "NanCaos";
                        }else
                        tipus = "Nan";
                    else if (personatges.get(i) instanceof Huma)
                        if(personatges.get(i) instanceof HumaOrdre){
                            tipus = "HumaOrdre";
                        }else if(personatges.get(i) instanceof HumaCaos){
                            tipus = "HumaCaos";
                        }else
                        tipus = "Huma";
                    else if (personatges.get(i) instanceof Mitja)                       
                        if(personatges.get(i) instanceof MitjaOrdre){
                            tipus = "MitjaOrdre";
                        }else if(personatges.get(i) instanceof MitjaCaos){
                            tipus = "MitjaCaos";
                        }else
                        tipus = "Mitja";
                    else if (personatges.get(i) instanceof Maia)
                        if(personatges.get(i) instanceof MaiaOrdre){
                            tipus = "MaiaOrdre";
                        }else if(personatges.get(i) instanceof MaiaCaos){
                            tipus = "MaiaCaos";
                        }else
                        tipus = "Maia";

                    System.out.printf("%d %s (%s)\n",(i+1),personatges.get(i).getNOM(),
                                                     tipus);
                }            
            }
            System.out.print("\nTria un personatge " + selec + ": ");
            int opcio =leerEnteroValido();
            seleccionats[opcio-1] = true;
            lluitadors[selec-1] = personatges.get(opcio-1);
            System.out.println("Personatge triat: " + 
                              personatges.get(opcio-1).getNOM());        
        }
        Dau dau1 = new Dau();
        Dau dau2 = new Dau();
        Dau dau3 = new Dau();
        // Inici combat
        Personatge atacant  = lluitadors[0];
        Personatge defensor = lluitadors[1];
        do{
            int valor =  dau1.llencar() + dau2.llencar() + dau3.llencar();        
            System.out.println("Valor daus: " + valor);
                if (valor <= atacant.getPA()) { // Atacant ataca
                    System.out.println(atacant.getNOM()+" Ataca!");
                    valor = dau1.llencar() + dau2.llencar() + dau3.llencar();
                    if (valor <= defensor.getPE()) { // Aconsegueix esquivar
                        System.out.println(defensor.getNOM()+" Esquiva!");
                        if(defensor instanceof Caos){
                        valor = dau1.llencar() + dau2.llencar() + dau3.llencar();
                        if(valor<=((Caos) defensor).atacPAReduida(defensor)){
                            System.out.println(defensor.getNOM()+"Contraataca!");
                            atacant.setPS(atacant.getPS()-defensor.getPD());
                        }
                    }
                    }else if(valor > defensor.getPE()){//no Aconsegueix esquivar
                        defensor.setPS(defensor.getPS() - atacant.getPD());
                        if(atacant instanceof Ordre){
                            ((Ordre) atacant).restaurarPS(atacant);
                        }
                    }
                }else if(valor > atacant.getPA()){
                    System.out.println(atacant.getNOM()+" no Ataca!");
                }
            Personatge aux = atacant;
            atacant  = defensor;
            defensor = aux;
        }while(atacant.PS>=0 || defensor.PS>=0);
        if(atacant.PS<=0){
            System.out.println(defensor.getNOM()+" ha guañat.");
            defensor.setPEX(atacant.getCON()+atacant.getFOR());
            if (defensor.pujaNivell()){
                System.out.println(defensor.getNOM()+" Puja de nivell");
            }
        }else if( defensor.PS<=0){
            System.out.println(atacant.getNOM()+" ha guañat.");
            atacant.setPEX(defensor.getCON()+defensor.getFOR());
            if(atacant.pujaNivell()){
                System.out.println(atacant.getNOM()+" Puja de nivell");   
            }
        }
        if(atacant instanceof Huma){
        atacant.setPS(atacant.getCON()+atacant.getFOR()+atacant.getINT());
        }else{
            atacant.setPS(atacant.getCON()+atacant.getFOR());
        }
        if(defensor instanceof Huma){
        defensor.setPS(defensor.getCON()+defensor.getFOR()+defensor.getINT());
        }else{
            defensor.setPS(defensor.getCON()+defensor.getFOR());
        }
    }
        
        
    public static int leerEnteroValido() {
        Scanner sc = new Scanner(System.in);

        while (true) {
            if (sc.hasNextInt()) {
                int num = sc.nextInt();
                return num;
            } else {
                System.out.println("Error: Opción no valida.");
                sc.next(); 
                System.out.println("Prueba de nuevo: ");
            }
        }
    }
    
}


