import React from 'react';
import './General.css'; // CSS file where you can define your styles
import { Link } from 'react-router-dom';
import { FaArrowRight } from "react-icons/fa";

class General extends React.Component {
    render() {
        //Sample players
        const players = [
            {
                name: 'Player 1',
                price: 'Price 1',
                position: 'DEF',
                points: 'Points 1',
                team: 'Team 1',
            },
            {
                name: 'Player 2',
                price: 'Price 2',
                position: 'RUCK',
                points: 'Points 2',
                team: 'Team 2',
            },
            {
                name: 'Player 3',
                price: 'Price 3',
                position: 'MID',
                points: 'Points 3',
                team: 'Team 3',
            },
            {
                name: 'Player 4',
                price: 'Price 4',
                position: "FWD",
                points: 'Points 4',
                team: 'Team 4',
            },
            // ...more players
        ];

        const teams = [
            {
                name: "Team 1",
                points: "10", 
            },
            {
                name: "Team 2",
                points: "15",
            },
            {
                name: "Team 3",
                points: "15",
            },
            {
                name: "Team 4",
                points: "25",
            },
            {
                name: "Team 4",
                points: "25",
            },
            {
                name: "Team 4",
                points: "25",
            },
            {
                name: "Team 5",
                points: "25",
            },
        ];
        
        return (
            <div className="container">

                {/*Table for players, show the ones in good form */}
                <table className="table">
                    <thead>
                    <tr className="table-header">
                        <th colSpan="5">
                        <div className='header-content'>
                            <div className='centre-text'>Players</div>
                                <Link to="/players">
                                    <button className="header-button">
                                        <FaArrowRight size={30}/>
                                    </button>
                                </Link>
                            </div>
                        </th>
                    </tr>
                    <tr>
                        <th>Player</th>
                        <th>Price</th>
                        <th>Position</th>
                        <th>Points</th>
                        <th>Team</th>
                    </tr>
                    </thead>
                    <tbody className='scrollable-tbody'>
                        {players.map((player, index) => (
                            <tr key={index}>
                                <td>
                                    <Link to={`/player/${player.id}`}>
                                        {player.name}
                                    </Link>
                                </td>
                                <td>{player.price}</td>
                                <td>{player.position}</td>
                                <td>{player.points}</td>
                                <td>{player.team}</td>
                            </tr>
                        ))}
                    </tbody>
                </table>

                {/*Table for teams*/}
                <table className="table">
                    <thead>
                        <tr className="table-header">
                            <th colSpan="3"><div className='centre-text'>Teams</div></th>
                        </tr>
                        <tr>
                            <th>Rank</th>
                            <th>Team</th>
                            <th>Points</th>
                        </tr>
                    </thead>
                    <tbody className='scrollable-tbody'>
                        {teams.map((team, index) => (
                            <tr key={index}>
                                <td>{index+1}</td>
                                <td>{team.name}</td>
                                <td>{team.points}</td>
                            </tr>
                        ))}
                    </tbody>
                </table> 

                <table className="table">
                    <thead>
                        <tr className='table-header'>
                            <th><div className='centre-text'>Results</div></th>
                        </tr>

                    </thead>
                    <tbody>
                        {/* Add your rows here */}
                    </tbody>
                </table>
            </div>
        );
    }
}

export default General;
