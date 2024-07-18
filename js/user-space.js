document.addEventListener("DOMContentLoaded", function() {
    // Vérification de la session de l'utilisateur
    fetch('../backend/check-session.php')
        .then(response => response.json())
        .then(data => {
            if (!data.loggedIn) {
                window.location.href = 'login.html';
                return;
            }

            // Afficher les informations de l'utilisateur
            fetch('../backend/user-info.php')
                .then(response => response.json())
                .then(userData => {
                    if (userData.error) {
                        document.getElementById('user-info').innerHTML = `<p>${userData.error}</p>`;
                        return;
                    }

                    document.getElementById('user-info').innerHTML = `
                        <p>Prénom: ${userData.user.firstname}</p>
                        <p>Nom: ${userData.user.lastname}</p>
                        <p>Email: ${userData.user.email}</p>
                    `;
                });

            // Afficher l'historique des paris
            fetch('../backend/bet-history.php')
                .then(response => response.json())
                .then(betData => {
                    if (betData.error) {
                        document.getElementById('bet-history').innerHTML = `<p>${betData.error}</p>`;
                        return;
                    }

                    const betHistorySection = document.getElementById('bet-history');
                    betHistorySection.innerHTML = '<table><tr><th>Match</th><th>Équipe</th><th>Montant</th><th>Statut</th></tr>';

                    betData.bets.forEach(bet => {
                        betHistorySection.innerHTML += `
                            <tr>
                                <td>${bet.match}</td>
                                <td>${bet.team}</td>
                                <td>${bet.amount}</td>
                                <td>${bet.status}</td>
                            </tr>
                        `;
                    });

                    betHistorySection.innerHTML += '</table>';
                });

            // Afficher le graphique
            fetch('../backend/bet-history.php')
                .then(response => response.json())
                .then(betData => {
                    if (betData.error) {
                        document.getElementById('dashboard').innerHTML = `<p>${betData.error}</p>`;
                        return;
                    }

                    const ctx = document.getElementById('betChart').getContext('2d');
                    const labels = betData.bets.filter(bet => bet.status === 'Terminé').map(bet => bet.date);
                    const data = betData.bets.filter(bet => bet.status === 'Terminé').map(bet => bet.amount);

                    new Chart(ctx, {
                        type: 'line',
                        data: {
                            labels: labels,
                            datasets: [{
                                label: 'Montants des paris',
                                data: data,
                                borderColor: 'rgba(75, 192, 192, 1)',
                                borderWidth: 1
                            }]
                        },
                        options: {
                            scales: {
                                x: {
                                    type: 'time',
                                    time: {
                                        unit: 'day'
                                    }
                                },
                                y: {
                                    beginAtZero: true
                                }
                            }
                        }
                    });
                });
        })
        .catch(error => {
            console.error('Erreur lors de la vérification de la session :', error);
        });
});
