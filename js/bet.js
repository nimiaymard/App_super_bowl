document.addEventListener("DOMContentLoaded", function() {
    // Vérifier si l'utilisateur est connecté
    fetch('../backend/check-session.php')
        .then(response => response.json())
        .then(data => {
            console.log('Session data:', data); // Log session data
            if (!data.loggedIn) {
                // Rediriger vers la page de connexion si l'utilisateur n'est pas connecté
                window.location.href = 'login.html';
            } else {
                // Charger les détails du match si l'utilisateur est connecté
                loadMatchDetails(data.userId);
            }
        });

    // Ajouter un écouteur d'événements pour le formulaire de pari
    document.getElementById('bet-form').addEventListener('submit', function(event) {
        event.preventDefault();

        const matchId = document.getElementById('match_id').value;
        const team = document.getElementById('team-select').value;
        const amount = document.getElementById('amount').value;

        fetch('../backend/place-bet.php', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: `match_id=${matchId}&team=${team}&amount=${amount}`
        })
        .then(response => response.json())
        .then(data => {
            console.log('Place bet response:', data); // Log place bet response
            if (data.error) {
                document.getElementById('error-message').textContent = data.error;
            } else {
                alert('Pari placé avec succès !');
                // Rediriger ou mettre à jour la page après le succès
                window.location.href = 'user-space.html';
            }
        })
        .catch(error => {
            console.error('Erreur lors du placement du pari :', error);
        });
    });

    // Ajouter un écouteur d'événements pour le bouton d'actualisation
    document.getElementById('update-button').addEventListener('click', function() {
        const matchId = document.getElementById('match_id').value;
        const team = document.getElementById('team-select').value;
        const amount = document.getElementById('amount').value;

        fetch('../backend/update-bet.php', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: `match_id=${matchId}&team=${team}&amount=${amount}`
        })
        .then(response => response.json())
        .then(data => {
            console.log('Update bet response:', data); // Log update bet response
            if (data.error) {
                document.getElementById('error-message').textContent = data.error;
            } else {
                alert('Pari mis à jour avec succès !');
                // Rediriger ou mettre à jour la page après le succès
                window.location.href = 'user-space.html';
            }
        })
        .catch(error => {
            console.error('Erreur lors de la mise à jour du pari :', error);
        });
    });
});

function loadMatchDetails(userId) {
    const urlParams = new URLSearchParams(window.location.search);
    const matchId = urlParams.get('match_id');

    if (!matchId) {
        alert('Match ID is missing');
        return;
    }

    document.getElementById('match_id').value = matchId;

    fetch(`../backend/match-details.php?match_id=${matchId}`)
        .then(response => response.json())
        .then(data => {
            console.log('Match details:', data); // Log match details
            if (data.error) {
                alert(data.error);
                return;
            }

            const matchTeamsElement = document.getElementById('match-teams');
            const oddsTeam1Element = document.getElementById('odds-team1');
            const oddsTeam2Element = document.getElementById('odds-team2');
            const teamSelectElement = document.getElementById('team-select');

            matchTeamsElement.innerHTML = `${data.match.team1} vs ${data.match.team2}`;
            oddsTeam1Element.innerHTML = `Cote pour ${data.odds[0].team}: ${data.odds[0].odds}`;
            oddsTeam2Element.innerHTML = `Cote pour ${data.odds[1].team}: ${data.odds[1].odds}`;

            teamSelectElement.innerHTML = `
                <option value="${data.odds[0].team}">${data.odds[0].team}</option>
                <option value="${data.odds[1].team}">${data.odds[1].team}</option>
            `;

            // Vérifier si une mise existe déjà
            fetch(`../backend/check-bet.php?match_id=${matchId}&user_id=${userId}`)
                .then(response => response.json())
                .then(betData => {
                    console.log('Bet data:', betData); // Log bet data
                    if (betData.exists) {
                        document.getElementById('amount').value = betData.amount;
                        document.getElementById('team-select').value = betData.team;
                        document.getElementById('bet-button').style.display = 'none';
                        document.getElementById('update-button').style.display = 'block';
                    }
                });
        })
        .catch(error => {
            console.error('Erreur lors de la récupération des détails du match :', error);
        });
}
