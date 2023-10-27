import React from "react";
import ModalPortal from "./components/ModalPortal";
import TestPage from './page/TestPage';

const ModalPortalExample = () => {
    const [opened, setOpened] = React.useState(false);

    const toggleModal = React.useCallback(() => {
        setOpened(!opened);
        }, [opened])

    return (
        <div>
            <button onClick={toggleModal}>Нажми</button>
            <ModalPortal children={<TestPage callback={toggleModal} />} isShowed={opened} callback={toggleModal} />
        </div>
        );
}

export default ModalPortalExample;