import React from 'react'

const Dangerous = ({ html = '', as: Component = 'div', ...rest }) => (
	<Component dangerouslySetInnerHTML={{ __html: html }} {...rest} />
)

export default Dangerous
