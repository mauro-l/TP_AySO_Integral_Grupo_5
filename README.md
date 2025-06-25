# TP AySO Integral - Grupo 5

## Guía Simple Git para el Equipo

### Setup Inicial (solo la primera vez)
```bash
git clone https://github.com/mauro-l/TP_AySO_Integral_Grupo_5.git
cd TP_AySO_Integral_Grupo_5
git checkout dev
```

### Para trabajar en tu parte:

#### 1. Crear tu rama personal
```bash
git checkout dev
git pull origin dev
git checkout -b tu-nombre-feature
```
Ejemplo: `git checkout -b dev_R6`

#### 2. Trabajar normal
- Crea/modifica tus archivos
- Haz las tareas que te asignaron

#### 3. Subir cambios
```bash
git status
git add .
git commit -m "Descripción simple de lo que hiciste"
git push origin tu-nombre-feature
```

#### 4. Crear Pull Request
1. Ve a GitHub → repositorio
2. Click "Compare & pull request" 
3. Llena el formulario automático
4. Click "Create pull request"
5. Avisa al grupo

### Flujo diario simple:
```bash
# Al empezar
git checkout dev
git pull origin dev
git checkout tu-rama
git merge dev

# Al terminar
git add .
git commit -m "Lo que hice hoy"
git push origin tu-rama
```

### Si algo sale mal:
```bash
# Deshacer último commit
git reset --soft HEAD~1

# Guardar cambios temporalmente
git stash

# Pedir ayuda en el grupo
```

### Nombres de ramas sugeridos:
- `juan-backup-scripts`
- `maria-firewall-config`
- `pedro-monitoring-setup`
- `ana-documentation`

### Reglas importantes:
1. NUNCA trabajar directamente en `dev` o `main`
2. Siempre crear tu propia rama
3. Si rompes algo, avisar inmediatamente
4. No subir contraseñas reales

### Dudas?
Preguntar en WhatsApp con captura del error.
