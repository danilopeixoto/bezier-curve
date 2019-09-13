// Lista de pontos de controle
ArrayList<Point> points = new ArrayList();

// Tamanho dos pontos de controle (raio)
float radius = 5.0;

// Índice de ponto de controle selecionado
int selection = -1;

// Deve desenhar linha de controle
boolean controlLine = true;

void setup() {
    // Configura tamanho da janela
    size(500, 500);
}

void draw() {
    // Configura plano de fundo para branco (limpa buffer de cor)
    background(255, 255, 255);
    
    // Desenha pontos de controle
    drawControlPoints();
    
    // Desenha linha de controle
    if (controlLine)
        drawControlLine();
}

// Se alguma tecla é pressionada executa "callback keyPressed"
void keyPressed() {
    // Se tecla "c" é pressionada deleta todos os pontos de controle
    if (key == 'c') {
        points.clear();
        selection = -1;
    }
    // Se tecla "h" é pressionada ativa ou desativa visualização da linha de controle
    else if (key == 'h')
        controlLine = !controlLine;
}

void mousePressed() {
    // Verifica se existe algum ponto de controle sob o "mouse" e marca como seleção
    for (int i = 0; i < points.size(); i++) {
        Point point = points.get(i);
        
        // Verifica se a posição do "mouse" está sob algum dos pontos de controle existente
        if (point.overlaps(mouseX, mouseY)) {
            selection = i;
            break;
        }
    }
    
    // Se não exite adiciona novo ponto de controle na posição do "mouse"
    if (mouseButton == LEFT && selection == -1) {
        points.add(new Point(mouseX, mouseY, radius));
        selection = points.size() - 1;
    }
    // Remove ponto de controle selecionado sob a posição do "mouse"
    else if (mouseButton == RIGHT && selection != -1) {
        points.remove(selection);
        selection = -1;
    }
}

// Se algum botão do "mouse" deixa de ser pressionado executa "callback mouseReleased"
void mouseReleased() {
    // Desmarca ponto de controle selecionado
    selection = -1;
}

// Se algum botão do "mouse" é pressionado executa "callback mousePressed"
void mouseDragged() {
    // Move ponto de controle selecionado junto com a posição do "mouse"
    if (selection != -1) {
        Point point = points.get(selection);
        
        // Função "clamp" mantem os pontos dentro dos limites da janela
        point.x = clamp(mouseX, 0, width);
        point.y = clamp(mouseY, 0, height);
    }
}

// Restrição de valor escalar em intervalo
float clamp(float x, float a, float b) {
    return Math.min(Math.max(x, a), b);
}

// Desenha pontos de controle
void drawControlPoints() {
    for (Point point : points)
        point.draw();
}

// Desenha linha de controle
void drawControlLine() {
    for (int i = 0; i < points.size() - 1; i++) {
        Point p0 = points.get(i);
        Point p1 = points.get(i + 1);
        
        // Desenha linha entre pontos de controle
        line(p0.x, p0.y, p1.x, p1.y);
    }
}
