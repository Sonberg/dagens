import { isCoordinate } from '@/validators/validators'
import { required } from 'vuelidate/lib/validators'

export default {
  Company: {
    name: {
      required
    },
    image: {},
    text: {
      required
    },
    geoLocation: {
      latitude: {
        required,
        isCoordinate
      },
      longitude: {
        required,
        isCoordinate
      }
    }
  }
}

export const data = () => ({
  Company: {
    name: '',
    image: '',
    text: '',
    geoLocation: {
      latitude: '',
      longitude: ''
    }
  }
})