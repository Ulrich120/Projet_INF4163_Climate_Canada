import { BrowserRouter, Route, Routes } from "react-router-dom";

import DashboardLayout from "./layouts/DashboardLayout";

import Home from "./pages/Home";
import Temperature from "./pages/Temperature";
import Precipitation from "./pages/Precipitation";
import Pollution from "./pages/Pollution";
import Results from "./pages/Results";
import Team from "./pages/Team";

function App() {
  return (
    <BrowserRouter>
      <DashboardLayout>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/temperature" element={<Temperature />} />
          <Route path="/precipitation" element={<Precipitation />} />
          <Route path="/pollution" element={<Pollution />} />
          <Route path="/results" element={<Results />} />
          <Route path="/team" element={<Team />} />
        </Routes>
      </DashboardLayout>
    </BrowserRouter>
  );
}

export default App;