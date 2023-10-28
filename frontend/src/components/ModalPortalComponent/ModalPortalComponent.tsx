import React, {FC, PropsWithChildren} from "react";
import ModalPortal from "./components/ModalPortal";

// export interface IModalPortalComponent extends PropsWithChildren {
//     onClick: (value: boolean) => void;
// }

const ModalPortalComponent: FC<PropsWithChildren> = ({children}) => {
    const [opened, setOpened] = React.useState(false);

    // const modifiedChildren = React.Children.map(children, child => {
    //     if (React.isValidElement(child)) {
    //       // Если child - элемент React, добавляем или изменяем props
    //       return React.cloneElement(child, {
    //         // Добавляем или изменяем props в дочернем компоненте
    //         someProp: someProp,
    //       });
    //     }
    //     // Если это не элемент React, возвращаем его без изменений
    //     return child;
    //   });

    const toggleModal = React.useCallback(() => {
        setOpened(!opened);
        }, [opened])

    return (
        <div>
            <button onClick={toggleModal}>Нажми</button>
            <ModalPortal children={ children } isShowed={opened} callback={toggleModal} />
        </div>
        );
}

export default ModalPortalComponent;