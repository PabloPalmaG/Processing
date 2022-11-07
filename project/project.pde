PImage background, bird, cano, menu;//Definiendo variables para las imagenes a utilizar
PFont font; //Definiendo variable para la fuente

boolean playing, gameover = false; // Definiendo jugar y perdiste como falso

int backX, y, vy, score = 0, highScore = 0, backSpeed = 2; //Definicion de las variables a usar

int[] canoX = new int[2]; //Tubo X - Asigna una matriz de 2 enteros adyacentes?
int[] canoY = new int[2]; //Tubo Y - Asigna una matriz de 2 enteros adyacentes?

void setup() {
  if (highScore>=10) {
    backSpeed++;    //Si tu record es mayor a 10 de puntuacion la velocidad de aceleracion aumentara
  }

  frameRate(60);//Especifica el número de fotogramas que se mostrarán cada segundo, en este caso seran 60.
  //loadImage: Cargando imagen
  //resize: Modificando tamaño de la imagen
  background = loadImage("as.png");
  background.resize(1600, 800);
  menu = loadImage("enter.jpg");
  //(1200, 800)
  menu.resize(600, 800);
  bird = loadImage("ufo.png");
  bird.resize(100, 100);
  cano = loadImage("separator.png");
  cano.resize(100, 550);
  font = createFont("Georgia", 22);//Convierte dinámicamente una fuente al formato utilizado por Processing
  
  playing = false;//Jugando se convertira en un falso.
//(1200, 800)
  size(600, 800);//Tamaño de la ventana
}

void draw() {
  if (backX == -1200) backX = 0; //Si backX es igual a -1200 entonces backX va a pasar a ser igual a 0 (background en posicion X (cambiante)).

  if (!playing) { //Si es diferente de jugar entonces
    println(keyCode); //Imprime keyCode (la tecla que se presione la va a detectar y en base a eso vera que proceso asignado puede hacer).
    //(600)+300
    canoX[0] = 600; //Tubo x en posicion 0 es igual a 600
    canoY[0] = (height/2); //Tubo y en posicion 0 es igual a la altura entre 2
    //(900)+300
    canoX[1] = 900; //Tubo x en posicion 1 es igual a 900
    canoY[1] = (600); //Tubo y en posicion 1 es igual a 600
    //definiendo valor a variables
    y = 50; 
    vy = 0; // Variable que definira la velocidad en la que empezara a descender
    backX = 0; //Variable que definira la poscicion cambiante del background con respecto a X
    
    imageMode(CENTER);//Modifica la ubicación desde la que se dibujan las imágenes al cambiar la forma en que se interpretan los parámetros proporcionados a image().
     //En center lo que sucede es que interpreta el segundo y tercer parámetro de image()como punto central de la imagen.
    image(menu, width/2, height/2);//dibuja lo que seria el menu en la ventana de visualización. El ancho y la altura se especifica que seran divididos entre 2 cada 1.

    fill(50,250,75); //Color de la letra
    textFont(font); //Establece la fuente actual que se dibujará
    textAlign(CENTER, CENTER);//Posicion del texto
    //Escritos posicionados en tal parte
    text("presiona < SPACE > para saltar", width/2, height/2 -50);
    text("presiona < ENTER > para jugar", width/2, height/2 + 10);
    //Escrito con tamaño modificado y ademas un agregado que mostrara la puntuacion mas alta lograda.
    textSize(40);
    fill(0);
    text("Puntuacion mas alta = " + highScore, width/2, height/2 + 290);
    //Cuando sea gameover entonces aparecera un texto que te dira intenta de nuevo
    if (gameover) { 
      textSize(40);
      fill(255,255,0);
      text("¡Intenta de nuevo!", width/2, 60);
    }
  }

  if (playing) {//Cuando sea playing entonces
    imageMode(CORNER); //Modifica la ubicación desde la que se dibujan las imágenes al cambiar la forma en que se interpretan los parámetros proporcionados a image().
    //Corner interpreta el segundo y tercer parámetro de image() como la esquina superior izquierda de la imagen.
    image(background, backX, 0);//El background con posicion x en backX y Y en 0
    image(background, backX+background.width, 0);//Lo mismo de arriba pero esta vez sumando un background.width """""""?
    backX = backX-backSpeed; //Cambio de valor a backX en el cual se le descontara lo que valga backSpeed

    textSize(50);
    drawBird(); //Inicializando
    drawCano(); //Inicializando
    text(score, width/2, 30); //Mostrar marcador
  }
}

void drawBird() { 
  imageMode(CENTER); //Modifica la ubicación desde la que se dibujan las imágenes al cambiar la forma en que se interpretan los parámetros proporcionados a image().
     //En center lo que sucede es que interpreta el segundo y tercer parámetro de image()como punto central de la imagen.
  image(bird, width/2, y); //El pajaro con posicion x en el ancho sobre 2 y Y en la variable y
  vy = vy+1; // A la velocidad en la que se mueve el pajaro en forma de Y se le aumentara 1(descendera si lo vemos desde forma de player).
  y = y+vy; // Es igual + el valor de vy.
}

void drawCano() {
  for (int i=0; i<2; i++) { //Va a hacer un recorrido de i empezando desde 0 hasta terminar en algo menor a 2. Cada recorrido aumentara el valor de i en 1.
    imageMode(CENTER);//Modifica la ubicación desde la que se dibujan las imágenes al cambiar la forma en que se interpretan los parámetros proporcionados a image().
     //En center lo que sucede es que interpreta el segundo y tercer parámetro de image()como punto central de la imagen.
    image(cano, canoX[i], canoY[i] - (cano.height/2+100)); //El tubo con posicion X dependiendo del valor de canoX[i] 
    //y con posicion Y dependiendo del valor dado de la operacion de la division de la altura del tubo sobre 2, a esto ademas sumarle 100 y para finalizar restarselo al valor de canoY[i]
    //i sera la variable cambiante y asignara la posicion en la que se deberia de encontrar.
    image(cano, canoX[i], canoY[i] + (cano.height/2+100));//Basicamente coloca un tubo igual pero en posicion Y contraria para hacer la creacion de un espacio en el cual debera pasar el bird.
    canoX[i] = canoX[i] - 2; //El tubo en posicion X sera restado en 2 unidades.

    if (canoX[i] < 0) { //Si canoX en la posicion i es menor a 0 entonces entrara y hara:
      canoY[i]= (int)random(200, height-200); //Coloca un tubo con posicion Y aleatoria cuando X llega a posicion 0
      canoX[i] = width; //La posicion de canoX en i sera igual al ancho
    }

    if (canoX[i] == width/2) { //Si canoX en valor i es igual al ancho entre 2 entonces entrara
      score++; //Aumentara el valor de la variable Score en 1
      highScore = max(score, highScore); // Este guardara el maximo obtenido de la puntuacion marcada de score en la variable highScore para despues mostrarla.
    }
    if (y>height || y<0 || (abs(width/2-canoX[i])<40 && abs(y-canoY[i])>90)) { //Si Y es mayor a la altura o si Y es menor a 0 o si basicamente sucede un error entonces se ejecutara lo de adentro.
      //Jugando sera igual a falso, la puntuacion se ira al valor 0 y en ese momento juego terminado se activara(true).
      playing = false; 
      score = 0;
      gameover = true;
    }
  }
}

void keyPressed() {
  //ALREVES
  if (keyCode == 32) {//Se debe de presionar la tecla space (igual a 32) para poder entrar
    vy = -16; //Este hace que cada que vez que se ejecute el bird ascienda hacia arriba en -16.
  }
  //Si keyCode es igual a 10 (La tecla enter) y es diferente de jugando entonces jugando sera igual a verdadero y juego terminado se deshabilitara(false).
  if (keyCode == 10 && !playing) { 
    playing = true;
    gameover = false;
  }
}
