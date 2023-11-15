import React from 'react';
import './App.css';
import { BrowserRouter, Route, Routes } from 'react-router-dom';
import Sidebar from './components/Sidebar';
import Home from './pages/Homepage/Home.js';
import About from './pages/About.js';
import Analytics from './pages/Analytics.js';
import Players from './pages/Players/PlayersPage';

const App = () => {
  return (
    <BrowserRouter>
      <Sidebar>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/home" element={<Home />} />
          <Route path="/about" element={<About />} />
          <Route path="/analytics" element={<Analytics />} />
          <Route path ="/players" element={<Players/>} />
        </Routes>
      </Sidebar>

    </BrowserRouter>
  );
};

export default App;