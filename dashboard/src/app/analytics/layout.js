import Navbar from "../../components/navbar"
import Sidepane from "../../components/sidepane"


export default function DashboardLayout({ children }) {
    return (<div>
        <Navbar />
        <Sidepane />
        {children}
        </div>)
}