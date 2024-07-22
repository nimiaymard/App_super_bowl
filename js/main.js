document.addEventListener("DOMContentLoaded", function() {
    const matchesList = document.getElementById('matches-list');
    const loginButton = document.getElementById('login-button');

    // Toujours afficher le bouton "Mon espace"
    loginButton.style.display = 'block';

    fetch('../backend/index.php')
        .then(response => response.json())
        .then(data => {
            if (data.matches && data.matches.length > 0) {
                data.matches.forEach(match => {
                    const matchElement = document.createElement('div');
                    matchElement.className = 'match';
                    matchElement.innerHTML = `
                        <h3>${match.team1} vs ${match.team2}</h3>
                        <p>Heure : ${match.time}</p>
                        <p>Statut : ${match.status}</p>
                    `;
                    matchesList.appendChild(matchElement);
                });
            } else {
                matchesList.innerHTML = '<p>Aucun match disponible pour aujourd\'hui.</p>';
            }
        })
        .catch(error => {
            console.error('Erreur lors de la récupération des données :', error);
            matchesList.innerHTML = '<p>Erreur lors de la récupération des données.</p>';
        });

    fetch('../backend/check-session.php')
        .then(response => response.json())
        .then(data => {
            if (data.loggedIn) {
                loginButton.innerHTML = '<a href="logout.php">Déconnexion</a>';
            } else {
                loginButton.innerHTML = '<a href="login.html">Mon espace</a>';
            }
        })
        .catch(error => {
            console.error('Erreur lors de la vérification de la session :', error);
        });
});
