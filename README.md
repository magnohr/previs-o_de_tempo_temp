# 🌤️ Previsão de Tempo — Flutter

Um aplicativo de **previsão do tempo** desenvolvido em **Flutter (Dart)** que exibe informações climáticas em tempo real de forma **visual**, **moderna** e **intuitiva**.

---

## 📱 Funcionalidades

O aplicativo exibe:

- 🏙️ **Nome da cidade**
- 🌡️ **Temperatura atual**
- 🔺 **Temperatura máxima**
- 🔻 **Temperatura mínima**
- ☁️ **Clima e condição atual** (sol, chuva, nublado, etc)
- 🔍 **Pesquisa por cidade** (qualquer lugar do mundo)

---

## 🔍 Pesquisa por cidade

| Tela 1 | Tela 2 |
|-------|--------|
| <img src="https://github.com/user-attachments/assets/db7ce818-f667-4ca1-9b83-bd4939ce563c" width="230"/> | <img src="https://github.com/user-attachments/assets/43df3da9-9db6-43b8-bae9-5e3c62e98ade" width="230"/> |

✔️ Busca global  
✔️ Dados atualizados em tempo real  
✔️ Interface simples e rápida  

---

## 🎨 Tema dinâmico por horário

O visual do aplicativo muda automaticamente de acordo com o **horário do dia**.

---

### ☀️ Manhã / Dia

| Tela 1 | Tela 2 |
|-------|--------|
| <img src="https://github.com/user-attachments/assets/b434927d-ce46-4752-b3d2-f47aa9e679ca" width="230"/> | <img src="https://github.com/user-attachments/assets/5170ac2a-e30f-474b-8364-56a3d669563f" width="230"/> |

---

### 🌆 Tarde

| Tela 1 | Tela 2 |
|-------|--------|
| <img src="https://github.com/user-attachments/assets/d824dfc3-67c3-45b9-befa-948bd966e148" width="230"/> | <img src="https://github.com/user-attachments/assets/463206b4-1b1d-43f3-9b8e-b71cdbc521c1" width="230"/> |

---

### 🌙 Noite

| Tela 1 | Tela 2 |
|-------|--------|
| <img src="https://github.com/user-attachments/assets/9fe4657c-136a-4d4d-b983-6fc79f16749c" width="230"/> | <img src="https://github.com/user-attachments/assets/0e795475-cbcb-4fa1-969b-6804cd546094" width="230"/> |

---

## 🌐 API Utilizada

☁️ **OpenWeatherMap API**

Responsável por fornecer:
- Clima atual
- Previsão por hora
- Previsão diária

---

## 🛠️ Tecnologias Utilizadas

- 💙 **Flutter**
- 🎯 **Dart**
- 🌐 **HTTP**
- 🧠 **Provider (ChangeNotifier)**
- 🖼️ **Assets dinâmicos**
- ☁️ **OpenWeatherMap API**

---

## 🧩 Arquitetura do Projeto

```txt
📂 controller  → lógica de negócio e consumo da API
📂 models      → modelos de dados do clima
📂 services    → geolocalização e integrações
📂 ui/widgets  → interface, telas e componentes
