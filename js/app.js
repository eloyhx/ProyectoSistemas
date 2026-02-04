
         JAVASCRIPT
        // ============================================
        // GESTIÓN DE SECCIONES
        // ============================================
        
        function showSection(sectionId) {
            // Ocultar todas las secciones
            document.querySelectorAll('.section-detail').forEach(section => {
                section.classList.remove('active');
            });

            
            
            // Ocultar/mostrar inicio
            const inicio = document.getElementById('inicio');
            if (sectionId === 'inicio') {
                inicio.style.display = 'block';
                window.scrollTo({ top: 0, behavior: 'smooth' });
            } else {
                inicio.style.display = 'none';
                const targetSection = document.getElementById(sectionId);
                if (targetSection) {
                    targetSection.classList.add('active');
                    if(sectionId === 'quiz-detalle') loadQuiz();
                    targetSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
                }
            }
            
            // Actualizar navegación activa
            document.querySelectorAll('.nav-link').forEach(link => {
                link.classList.remove('active');
                if (link.getAttribute('onclick').includes(sectionId)) {
                    link.classList.add('active');
                }
            });
            
            // Cerrar menú móvil si está abierto
            document.getElementById('navLinks').classList.remove('active');
        }

        // ============================================
        // GESTIÓN DE MODALES
        // ============================================
        
        function openModal(modalId) {
            const modal = document.getElementById(modalId);
            if (modal) {
                modal.classList.add('active');
                document.body.style.overflow = 'hidden'; // Prevenir scroll del body
            }
        }

        function closeModal(modalId) {
            const modal = document.getElementById(modalId);
            if (modal) {
                modal.classList.remove('active');
                document.body.style.overflow = ''; // Restaurar scroll
            }
        }

        function closeModalOnOverlay(event) {
            if (event.target === event.currentTarget) {
                closeModal(event.target.id);
            }
        }

        // Cerrar modal con tecla ESC
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') {
                document.querySelectorAll('.modal-overlay.active').forEach(modal => {
                    closeModal(modal.id);
                });
            }
        });

        // ============================================
        // TEMA CLARO/OSCURO
        // ============================================
        
        function toggleTheme() {
            const html = document.documentElement;
            const icon = document.getElementById('themeIcon');
            
            if (html.classList.contains('dark')) {
                html.classList.remove('dark');
                localStorage.setItem('theme', 'light');
                icon.classList.remove('fa-sun');
                icon.classList.add('fa-moon');
            } else {
                html.classList.add('dark');
                localStorage.setItem('theme', 'dark');
                icon.classList.remove('fa-moon');
                icon.classList.add('fa-sun');
            }
        }

        // Cargar tema guardado al iniciar
        function loadTheme() {
            const savedTheme = localStorage.getItem('theme');
            const icon = document.getElementById('themeIcon');
            
            if (savedTheme === 'dark') {
                document.documentElement.classList.add('dark');
                icon.classList.remove('fa-moon');
                icon.classList.add('fa-sun');
            }
        }

        // ============================================
        // MENÚ MÓVIL
        // ============================================
        
        function toggleMenu() {
            const navLinks = document.getElementById('navLinks');
            navLinks.classList.toggle('active');
        }

        // ============================================
        // CERTIFICADO INTERACTIVO
        // ============================================
        
        function generarCertificado() {
            const nombre = prompt('¡Felicidades! 🎉\n\nIntroduce tu nombre completo para generar el certificado:');
            
            if (nombre && nombre.trim() !== '') {
                const certDisplay = document.getElementById('certificado-display');
                const certNombre = document.getElementById('cert-nombre');
                const certFecha = document.getElementById('cert-fecha');
                
                certNombre.textContent = nombre.trim();
                certFecha.textContent = new Date().toLocaleDateString('es-ES', {
                    year: 'numeric',
                    month: 'long',
                    day: 'numeric'
                });
                
                certDisplay.style.display = 'block';
                certDisplay.scrollIntoView({ behavior: 'smooth', block: 'center' });
                
                // Efecto de confeti simulado con console log (en producción usar librería)
                console.log('🎉 Certificado generado para:', nombre);
            } else if (nombre !== null) {
                // Usuario introdujo texto vacío
                alert('Por favor, introduce un nombre válido para generar el certificado.');
            }
            // Si nombre es null, usuario canceló el prompt - no hacer nada
        }

        // ============================================
        // SIMULACIÓN DE DESCARGAS
        // ============================================
        
        function simularDescarga(nombreArchivo) {
            // Crear notificación visual en lugar de alert
            const notificacion = document.createElement('div');
            notificacion.style.cssText = `
                position: fixed;
                bottom: 20px;
                right: 20px;
                background: linear-gradient(135deg, var(--verde), #2acc10);
                color: #0a0a0a;
                padding: 1rem 1.5rem;
                border-radius: 10px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.3);
                z-index: 3000;
                display: flex;
                align-items: center;
                gap: 0.75rem;
                font-weight: 600;
                animation: slideInRight 0.3s ease;
            `;
            notificacion.innerHTML = `
                <i class="fas fa-check-circle"></i>
                <span>Descargando ${nombreArchivo}...</span>
            `;
            
            document.body.appendChild(notificacion);
            
            // Remover después de 3 segundos
            setTimeout(() => {
                notificacion.style.animation = 'slideOutRight 0.3s ease';
                setTimeout(() => notificacion.remove(), 300);
            }, 3000);
        }

        // Animaciones para notificaciones
        const style = document.createElement('style');
        style.textContent = `
            @keyframes slideInRight {
                from { transform: translateX(100%); opacity: 0; }
                to { transform: translateX(0); opacity: 1; }
            }
            @keyframes slideOutRight {
                from { transform: translateX(0); opacity: 1; }
                to { transform: translateX(100%); opacity: 0; }
            }
        `;
        document.head.appendChild(style);

        // ============================================
        // INICIALIZACIÓN
        // ============================================
        
        document.addEventListener('DOMContentLoaded', () => {
            loadTheme();
            
            // Animación de entrada para tarjetas al hacer scroll
            const observerOptions = {
                threshold: 0.1,
                rootMargin: '0px 0px -50px 0px'
            };
            
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }
                });
            }, observerOptions);
            
            document.querySelectorAll('.card, .timeline-item').forEach(el => {
                observer.observe(el);
            });
        });

        // Prevenir errores de consola por elementos no encontrados
        window.onerror = function(msg, url, lineNo, columnNo, error) {
            console.log('Error capturado (no crítico):', msg);
            return false;
        };

        /* ======================
   QUIZ PRO
====================== */

const quizQuestions = [
{
    q: "¿Qué hace echo off?",
    options: ["Oculta los comandos", "Borra archivos", "Reinicia Windows"],
    correct: 0
},
{
    q: "¿Qué comando repara archivos del sistema?",
    options: ["dir", "sfc /scannow", "netstat"],
    correct: 1
},
{
    q: "¿Para qué sirve netstat?",
    options: ["Ver conexiones de red", "Formatear disco", "Crear carpetas"],
    correct: 0
},
{
    q: "¿Qué instrucción ejecuta otro script?",
    options: ["goto", "call", "echo"],
    correct: 1
}
];

let quizIndex = 0;
let quizScore = 0;

function loadQuiz() {

    const box = document.getElementById("quiz-box");
    const progress = document.getElementById("quiz-progress-bar");

    if(!box) return;

    if(quizIndex >= quizQuestions.length){
        showResult();
        return;
    }

    const q = quizQuestions[quizIndex];

    progress.style.width = ((quizIndex / quizQuestions.length) * 100) + "%";

    box.innerHTML = `
        <div class="quiz-question">${q.q}</div>
        <div class="quiz-options">
            ${q.options.map((o,i)=>`<button onclick="answerQuiz(${i})">${o}</button>`).join("")}
        </div>
        <p style="margin-top:1rem;">Pregunta ${quizIndex+1}/${quizQuestions.length}</p>
    `;
}

function answerQuiz(i){

    const buttons = document.querySelectorAll(".quiz-options button");

    buttons.forEach(b => b.disabled = true);

    if(i === quizQuestions[quizIndex].correct){
        buttons[i].classList.add("quiz-correct");
        quizScore++;
    } else {
        buttons[i].classList.add("quiz-wrong");
        buttons[quizQuestions[quizIndex].correct].classList.add("quiz-correct");
    }

    setTimeout(() => {
        quizIndex++;
        loadQuiz();
    }, 700);
}

function showResult(){

    const box = document.getElementById("quiz-box");
    const percent = Math.round((quizScore / quizQuestions.length)*100);

    let color = "var(--azul)";
    if(percent >= 80) color = "var(--verde)";
    if(percent < 50) color = "#ff4d4d";

    box.innerHTML = `
        <h2 style="color:${color}">Resultado final</h2>
        <h3>${quizScore}/${quizQuestions.length} (${percent}%)</h3>
        <button class="btn-card" onclick="restartQuiz()">Reintentar</button>
    `;
}

function restartQuiz(){
    quizIndex = 0;
    quizScore = 0;
    loadQuiz();
}

    