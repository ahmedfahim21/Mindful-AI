import Navbar from "../../components/navbar"
import Sidepane from "../../components/sidepane"


export default function DashboardLayout({ children }) {
    return (<section>
        <Navbar />
        <Sidepane />
        {children}
        </section>)
}