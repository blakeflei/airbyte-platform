import { PropsWithChildren } from "react";

import { getLinkClassNames } from "./getLinkClassNames";
import { LinkProps } from "./Link";

interface ExternalLinkProps extends LinkProps {
  href: string;
  withIcon?: boolean;
}

export const ExternalLink: React.FC<PropsWithChildren<ExternalLinkProps>> = ({
  children,
  className,
  opensInNewTab = true,
  href,
  variant,
  withIcon,
  ...props
}) => {
  return (
    <a
      {...props}
      className={getLinkClassNames({ className, variant })}
      href={href}
      rel="noreferrer"
      target={opensInNewTab ? "_blank" : undefined}
    >
      {children}
    </a>
  );
};
